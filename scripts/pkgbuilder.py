#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

import sys
import os
import datetime, time
import argparse
import json
import codecs
import threading
import queue
import subprocess
import multiprocessing
import signal
import fcntl, termios, struct

# Ensure we can output any old crap to stdout and stderr
sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
sys.stderr = codecs.getwriter("utf-8")(sys.stderr.detach())

# derive from subprocess to utilize wait4() for rusage stats
class RusagePopen(subprocess.Popen):
    def _try_wait(self, wait_flags):
        try:
            (pid, sts, ru) = os.wait4(self.pid, wait_flags)
        except OSError as e:
            if e.errno != errno.ECHILD:
                raise
            pid = self.pid
            sts = 0
        else:
            self.rusage = ru
        return (pid, sts)

def rusage_run(*popenargs, parent=None, timeout=None, **kwargs):
    with RusagePopen(*popenargs, **kwargs) as process:
        try:
            parent.child = process
            stdout, stderr = process.communicate(None, timeout=timeout)
        except subprocess.TimeoutExpired as exc:
            process.kill()
            process.wait()
            raise
        except:
            process.kill()
            raise
        retcode = process.poll()
    res = subprocess.CompletedProcess(process.args, retcode, stdout, stderr)
    res.rusage = process.rusage
    parent.child = None
    return res

class GeneratorEmpty(Exception):
    pass

class GeneratorStalled(Exception):
    pass

class Generator:
    def __init__(self, plan):
        self.work = plan

        self.totalJobs = len(plan)
        self.building = {}
        self.built = {}
        self.failed = {}
        self.removedPackages = {}

        self.check_no_deps = True

        # Transform unpack info from package:target to just package - simplifying refcount generation
        # Create a map for sections, as we don't autoremove "virtual" packages
        self.unpacks = {}
        self.sections = {}
        for job in self.work:
            (pkg_name, target) = job["name"].split(":")
            if pkg_name not in self.unpacks:
                self.unpacks[pkg_name] = job["unpacks"]
                self.sections[pkg_name] = job["section"]
                for unpack in job["unpacks"]:
                    if unpack not in self.sections:
                        self.sections[unpack] = "" # don't know section, assume not virtual

        # Count number of times each package is referenced by package:target (including itself) and
        # then recursively accumulate counts for any other packages that may be referenced
        # by "PKG_DEPENDS_UNPACK".
        # Once the refcount is zero for a package, the source directory can be removed.
        self.refcount = {}
        for job in self.work:
            (pkg_name, target) = job["name"].split(":")
            self.refcount[pkg_name] = self.refcount.get(pkg_name, 0) + 1
            for pkg_name in job["unpacks"]:
                self.addRefCounts(pkg_name)

    def canBuildJob(self, job):
        for dep in job["wants"]:
            if dep not in self.built:
                return False

        return True

    def getPackagesToRemove(self, job):
        packages = {}

        pkg_name = job["name"].split(":")[0]
        packages[pkg_name] = True
        for pkg_name in job["unpacks"]:
            self.addUnpackPackages(pkg_name, packages)

        for pkg_name in packages:
            if self.refcount[pkg_name] == 0 and \
                self.sections[pkg_name] != "virtual" and \
                pkg_name not in self.removedPackages:
                yield pkg_name

    def getPackageReferenceCounts(self, job):
        packages = {}

        pkg_name = job["name"].split(":")[0]
        packages[pkg_name] = True
        for pkg_name in job["unpacks"]:
            self.addUnpackPackages(pkg_name, packages)

        for pkg_name in packages:
            tokens = ""
            tokens += "[v]" if self.sections[pkg_name] == "virtual" else ""
            tokens += "[r]" if pkg_name in self.removedPackages else ""
            yield(f"{pkg_name}:{self.refcount[pkg_name]}{tokens}")

    def getFirstFailedJob(self, job):
        for dep in job["wants"]:
            if dep in self.failed:
                failedjob = self.getFirstFailedJob(self.failed[dep])
                if not failedjob:
                    return self.failed[dep]
                else:
                    return failedjob

        return None

    def getAllFailedJobs(self, job):
        flist = {}
        for dep in job["wants"]:
            if dep in self.failed:
                failedjob = self.getFirstFailedJob(self.failed[dep])
                if failedjob:
                    flist[failedjob["name"]] = failedjob
                else:
                    flist[dep] = self.failed[dep]

        return [flist[x] for x in flist]

    def getNextJob(self):
        if self.work == []:
            raise GeneratorEmpty

        # Always process jobs without dependencies first
        # until we're sure there's none left...
        if self.check_no_deps:
            for i, job in enumerate(self.work):
                if job["wants"] == []:
                    self.building[job["name"]] = True
                    del self.work[i]
                    job["failedjobs"] = self.getAllFailedJobs(job)
                    job["logfile"] = None
                    job["cmdproc"] = None
                    job["failed"] = False
                    return job

            self.check_no_deps = False

        # Process remaining jobs, trying to schedule
        # only those jobs with all their dependencies satisfied
        for i, job in enumerate(self.work):
            if self.canBuildJob(job):
                self.building[job["name"]] = True
                del self.work[i]
                job["failedjobs"] = self.getAllFailedJobs(job)
                job["logfile"] = None
                job["cmdproc"] = None
                job["failed"] = False
                return job

        raise GeneratorStalled

    # Return details about stalled jobs that can't build until the
    # currently building jobs are complete.
    def getStallInfo(self):
        for job in self.work:
            for dep in job["wants"]:
                if dep not in self.building and dep not in self.built:
                    break
            else:
                yield (job["name"], [d for d in job["wants"] if d in self.building])

    def activeJobCount(self):
        return len(self.building)

    def activeJobNames(self):
        for name in self.building:
            yield name

    def failedJobCount(self):
        return len(self.failed)

    def failedJobs(self):
        for name in self.failed:
            yield self.failed[name]

    def completedJobCount(self):
        return len(self.built)

    def totalJobCount(self):
        return self.totalJobs

    def completed(self, job):
        self.built[job["name"]] = job
        del self.building[job["name"]]

        if job["failed"]:
            self.failed[job["name"]] = job
        else:
            self.refcount[job["name"].split(":")[0]] -= 1

        for pkg_name in job["unpacks"]:
            self.delRefCounts(pkg_name)

    def removed(self, pkg_name):
        self.removedPackages[pkg_name] = True

    def addUnpackPackages(self, pkg_name, packages):
        packages[pkg_name] = True
        if pkg_name in self.unpacks:
            for p in self.unpacks[pkg_name]:
                self.addUnpackPackages(p, packages)

    def addRefCounts(self, pkg_name):
        self.refcount[pkg_name] = self.refcount.get(pkg_name, 0) + 1
        if pkg_name in self.unpacks:
            for p in self.unpacks[pkg_name]:
                self.addRefCounts(p)

    def delRefCounts(self, pkg_name):
        self.refcount[pkg_name] = self.refcount.get(pkg_name, 0) - 1
        if pkg_name in self.unpacks:
            for p in self.unpacks[pkg_name]:
                self.delRefCounts(p)

class BuildProcess(threading.Thread):
    def __init__(self, slot, maxslot, jobtotal, haltonerror, work, complete):
        threading.Thread.__init__(self, daemon=True)

        self.slot = slot
        self.maxslot = maxslot
        self.jobtotal = jobtotal
        self.haltonerror = haltonerror
        self.work = work
        self.complete = complete

        self.active = False

        self.child = None

        self.stopping = False

    def stop(self):
        self.stopping = True
        self.work.put(None)
        if self.child:
            try:
                os.killpg(os.getpgid(self.child.pid), signal.SIGTERM)
                self.child.wait()
            except:
                pass

    def isActive(self):
        return self.active == True

    def run(self):
        while not self.stopping:
            job = self.work.get(block=True)
            if job == None or self.stopping:
                break

            self.active = True

            job["slot"] = self.slot
            job["failed"] = self.execute(job)
            job["status"] = "FAIL" if job["failed"] else "DONE"
            self.complete.put(job)

            self.active = False

            if job["failed"] and self.haltonerror:
                break

    def execute(self, job):
        if job["failedjobs"]:
            flist = []
            for fjob in job["failedjobs"]:
                failedinfo = f"{fjob['task']},{fjob['name']}"
                if fjob["logfile"]:
                    failedinfo = f"{failedinfo},{fjob['seq']}"
                flist.append(failedinfo)
            failedinfo = ";".join(flist)
        else:
            failedinfo = ""

        job["args"] = [f"{ROOT}/{SCRIPTS}/pkgbuild",
                       f"{self.slot}", f"{job['seq']}", f"{self.jobtotal}", f"{self.maxslot}",
                       job["task"], job["name"], failedinfo]

        job["start"] = time.time()
        returncode = 1
        try:
            if job["logfile"]:
                with open(job["logfile"], "w") as logfile:
                    cmd = rusage_run(job["args"], cwd=ROOT,
                                     stdin=subprocess.PIPE, stdout=logfile, stderr=subprocess.STDOUT,
                                     universal_newlines=True, shell=False, parent=self, start_new_session=True)
                returncode = cmd.returncode
                job["cmdproc"] = cmd
            else:
                try:
                    cmd = rusage_run(job["args"], cwd=ROOT,
                                     stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                     universal_newlines=True, shell=False, parent=self, start_new_session=True,
                                     encoding="utf-8", errors="replace")
                    returncode = cmd.returncode
                    job["cmdproc"] = cmd
                except UnicodeDecodeError:
                    print(f'\nPKGBUILDER ERROR: UnicodeDecodeError while reading cmd.stdout from "{job["task"]} {job["name"]}"\n', file=sys.stderr, flush=True)
        except Exception as e:
            print(f"\nPKGBUILDER ERROR: {str(e)} exception while executing: {job['args']}\n", file=sys.stderr, flush=True)

        job["end"] = time.time()
        job["elapsed"] = job["end"] - job["start"]

        if job["cmdproc"]:
            job["utime"] = job["cmdproc"].rusage.ru_utime
            job["stime"] = job["cmdproc"].rusage.ru_stime
        else:
            job["utime"] = job["stime"] = 0

        if job["elapsed"] == 0.0:
            job["cpu"] = 0.0
        else:
            job["cpu"] = round((job["utime"] + job["stime"]) * 100 / job["elapsed"])

        return (returncode != 0)

class Builder:
    def __init__(self, maxthreadcount, inputfilename, jobglog, loadstats, stats_interval, \
                 haltonerror=True, failimmediately=True, log_burst=True, log_combine="always", \
                 bookends=True, autoremove=False, colors=False, progress=False, debug=False, verbose=False):
        if inputfilename == "-":
            plan = json.load(sys.stdin)
        else:
            with open(inputfilename, "r") as infile:
                plan = json.load(infile)

        self.generator = Generator(plan)

        self.jobtotal = self.generator.totalJobCount()
        self.twidth = len(f"{self.jobtotal}")

        # parse threadcount
        if maxthreadcount.endswith("%"):
            self.threadcount = int(multiprocessing.cpu_count() / 100 * int(args.max_procs.replace("%","")))
        else:
            if args.max_procs == "0":
                self.threadcount = 256
            else:
                self.threadcount = int(maxthreadcount)

        self.threadcount = min(self.jobtotal, self.threadcount)
        self.threadcount = max(1, self.threadcount)

        if args.debug:
            DEBUG(f"THREADCOUNT#: input arg: {maxthreadcount}, computed: {self.threadcount}")

        self.joblog = jobglog
        self.loadstats = loadstats
        self.stats_interval = int(stats_interval)
        if self.stats_interval < 1:
            self.stats_interval = 60

        self.haltonerror = haltonerror
        self.failimmediately = failimmediately
        self.log_burst = log_burst
        self.log_combine = log_combine
        self.debug = debug
        self.verbose = verbose
        self.bookends = bookends
        self.autoremove = autoremove

        self.stdout_dirty = False
        self.stderr_dirty = False
        self.progress_dirty = False

        self.joblogfile = None
        self.loadstatsfile = None
        self.nextstats = 0
        self.build_start = 0

        self.work = queue.Queue()
        self.complete = queue.Queue()
        self.processes = []

        # Init all processes
        self.processes = []
        for i in range(1, self.threadcount + 1):
            self.processes.append(BuildProcess(i, self.threadcount, self.jobtotal, self.haltonerror, self.work, self.complete))

        # work and completion sequences
        self.wseq = 0
        self.cseq = 0

        self.progress = progress and sys.stderr.isatty()
        self.progress_glitch_fix = ""
        self.rows = self.columns = -1
        self.original_resize_handler = None
        if self.progress:
            self.getTerminalSize()
            self.resize_handler = signal.signal(signal.SIGWINCH, self.getTerminalSize)

        self.colors = (colors == "always" or (colors == "auto" and sys.stderr.isatty()))
        self.color_code = {}
        self.color_code["DONE"] = "\033[0;32m" #green
        self.color_code["FAIL"] = "\033[1;31m" #bold red
        self.color_code["ACTV"] = "\033[0;33m" #yellow
        self.color_code["IDLE"] = "\033[0;35m" #magenta
        self.color_code["INIT"] = "\033[0;36m" #cyan
        self.color_code["WAIT"] = "\033[0;35m" #magenta

    def build(self):
        if self.joblog:
            self.joblogfile = open(self.joblog, "w")

        if self.loadstats:
            self.loadstatsfile = open(self.loadstats, "w")

        self.build_start = time.time()

        for process in self.processes:
            process.start()

        # Queue new work until no more work is available, and all queued jobs have completed.
        while self.queueWork():
            job = self.getCompletedJob()

            self.writeJobLog(job)
            self.autoRemovePackages(job)
            self.processJobOutput(job)
            self.displayJobStatus(job)

            job["cmdproc"] = None
            job = None

        self.captureStats(finished=True)

        if self.joblogfile:
            self.joblogfile.close()

        if self.loadstatsfile:
            self.loadstatsfile.close()

        if self.generator.failedJobCount() != 0:
            if self.haltonerror and not self.failimmediately:
                failed = [job for job in self.generator.failedJobs() if job["logfile"]]
                if failed != []:
                    self.oprint("\nThe following log(s) for this failure are available:")
                    for job in failed:
                        self.oprint(f"  {job['name']} => {job['logfile']}")
                    self.oprint("", flush=True)
            return False

        return True

    # Fill work queue with enough jobs to keep all processes busy.
    # Return True while jobs remain available to build, or queued jobs are still building.
    # Return False once all jobs have been queued, and finished building.
    def queueWork(self):

        # If an error has occurred and we are not ignoring errors, then return True
        # (but don't schedule new work) if we are to exit after all currently
        # active jobs have finished, otherwise return False.
        if self.haltonerror and self.generator.failedJobCount() != 0:
            if not self.failimmediately and self.generator.activeJobCount() != 0:
                freeslots = self.threadcount - self.generator.activeJobCount()
                self.show_status("WAIT", "waiting", ", ".join(self.generator.activeJobNames()))
                DEBUG(f"Waiting for : {self.generator.activeJobCount()} active, {freeslots} idle [{', '}.join.self.generator.activeJobNames()]")
                return True
            else:
                return False

        try:
            for i in range(self.generator.activeJobCount(), self.threadcount):
                job = self.generator.getNextJob()

                if self.verbose:
                    self.show_status("INIT", "submit", job["name"])

                if self.debug:
                    DEBUG(f"Queueing Job: {job['task']} {job['name']}")

                self.wseq += 1
                job["seq"] = self.wseq
                if self.log_burst:
                    job["logfile"] = f"{THREAD_CONTROL}/logs/{job['seq']}.log"

                self.work.put(job)

            if self.verbose:
                self.show_status("ACTV", "active", ", ".join(self.generator.activeJobNames()))

            if self.debug:
                freeslots = self.threadcount - self.generator.activeJobCount()
                DEBUG(f"Building Now: {self.generator.activeJobCount()} active, {freeslots} idle [{', '.join(self.generator.activeJobNames())}]")

        except GeneratorStalled:
            if self.verbose:
                freeslots = self.threadcount - self.generator.activeJobCount()
                pending = []
                for (i, (package, wants)) in enumerate(self.generator.getStallInfo()):
                    pending.append(f"{package} (wants: {', '.join(wants)})")
                self.show_status("ACTV", "active", ", ".join(self.generator.activeJobNames()))
                self.show_status("IDLE", "stalled", "; ".join(pending), p1=len(pending))

            if self.debug:
                freeslots = self.threadcount - self.generator.activeJobCount()
                DEBUG(f"Building Now: {self.generator.activeJobCount()} active, {freeslots} idle [{', '.join(self.generator.activeJobNames())}]")
                for (i, (package, wants)) in enumerate(self.generator.getStallInfo()):
                    item = f"{package:<25} wants: {', '.join(wants)}"
                    if i == 0:
                        DEBUG(f"Stalled Jobs: {item}")
                    else:
                        DEBUG(f"              {item}")

        except GeneratorEmpty:
            if self.generator.activeJobCount() == 0:
                if self.debug:
                    DEBUG("NO MORE JOBS: All jobs have completed - exiting.")
                return False
            else:
                if self.debug:
                    n = self.generator.activeJobCount()
                    DEBUG(f"NO MORE JOBS: Waiting on {n} job{['s',''][n == 1]} to complete...")

        return True

    # Wait until a new job is available
    def getCompletedJob(self):
        while True:
            try:
                job = self.complete.get(block=True, timeout=self.captureStats(finished=False))
                self.generator.completed(job)

                if self.debug:
                    DEBUG(f"Finished Job: {job['task']} {job['name']} [{job['status']}] after {job['elapsed']:0.3f} seconds")

                return job

            except queue.Empty:
                pass

    def captureStats(self, finished=False):
        self.displayProgress()
        if finished:
            self.clearProgress()
        self.flush()

        if not self.loadstatsfile:
            if self.progress:
                now = time.time()
                return int(now + 1) - now
            else:
                return None

        now = time.time()
        if now >= self.nextstats or finished:
            self.nextstats = int(now - (now % self.stats_interval)) + self.stats_interval

            loadavg = self.getLoad()
            procs = loadavg[3].split("/")
            meminfo = self.getMemory()

            print(
                (
                f"{now} {now - self.build_start:06} {loadavg[0]:5} {loadavg[1]:5} {loadavg[2]:5}"
                f" {procs[0]:3} {procs[1]:4} {meminfo['MemAvailable']:9}"
                f" {self.generator.activeJobCount():2} {','.join(self.generator.activeJobNames())}"
                ), file=self.loadstatsfile, flush=True)

        if self.progress:
            return min((self.nextstats - now), int(now + 1) - now)
        else:
            return (self.nextstats - now)

    def displayProgress(self):
        if self.progress:
            freeslots = self.threadcount - self.generator.activeJobCount()
            if self.jobtotal != self.generator.completedJobCount():
                percent = f"{100 / self.jobtotal * self.generator.completedJobCount():0.2f}"
            else:
                percent = "100"
            loadavg = self.getLoad()
            meminfo = self.getMemory()
            available = int(meminfo["MemAvailable"]) / 1024

            lines = [ "",
                      (f"{self.secs2hms(time.time() - self.build_start)}: {percent:5}% | load: {loadavg[0]} "
                       f"mem: {available:.0f} MB | failed: {self.generator.failedJobCount()} idle: {freeslots} "
                       f"active: {self.generator.activeJobCount()}"),
                      f"Building: {', '.join(self.generator.activeJobNames())}"
                    ]

            columns = self.columns # in theory could change mid-loop
            output = []
            for line in lines:
                output.append(line if len(line) < columns else f"{line[0:columns - 2]}+")

            if not self.progress_glitch_fix:
                self.progress_glitch_fix = f"{chr(10) * len(output)}\033[{len(output)}A"

            # \033[?7l: disable linewrap
            # \033[0K: clear cursor to end of line (every line but last)
            # \033[0J: clear cursor to end of screen (last line)
            # \033{len(...)}A: move cursor up len(...) lines (move back to "home" position)
            # \033[?7h: re-enable linewrap
            #
            # When the console is resized to a narrower width, lines wider than the
            # new console width may be wrapped to a second line (depends on console
            # software, for example PuTTY) so disable line wrapping to prevent this.
            #
            self.eprint("\033[?7l%s\033[0J\r\033[%dA\033[?7h" % ("\033[0K\n".join(output), len(output) - 1),
                  end="\r", isProgress=True)
            self.progress_dirty = True

    def clearProgress(self):
        if self.progress and self.progress_dirty:
            self.progress_dirty = False
            self.eprint("\033[0J", end="")

    # Output completion info, and links to any relevant logs
    def displayJobStatus(self, job):
        self.cseq += 1
        self.show_status(job["status"], job["task"], job["name"], p1=self.cseq, p2=self.jobtotal)

        if job["failed"]:
            if job["logfile"]:
                self.eprint(f"\nThe following log for this failure is available:\n  {job['logfile']}\n")

            if job["failedjobs"] and job["failedjobs"][0]["logfile"]:
                if len(job["failedjobs"]) == 1:
                    self.eprint("The following log from the failed dependency may be relevant:")
                else:
                    self.eprint("The following logs from the failed dependencies may be relevant:")
                for fjob in job["failedjobs"]:
                    self.eprint(f"  {fjob['task']:<7} {fjob['name']} => {fjob['logfile']}")
                self.eprint("")

    # If configured, send output for a job (either a logfile, or captured stdout) to stdout
    def processJobOutput(self, job):
        log_processed = False
        log_size = 0
        log_start = time.time()

        if job["logfile"]:
            if self.log_combine == "always" or (job["failed"] and self.log_combine == "fail"):
                if self.bookends:
                    self.oprint(f"<<< {job['name']} seq {job['seq']} <<<")

                try:
                    with open(job["logfile"], "r", encoding="utf-8", errors="replace") as logfile:
                        for line in logfile:
                            self.oprint(line, end="")
                            log_size += len(line)
                except UnicodeDecodeError:
                    self.eprint(f"\nPKGBUILDER ERROR: UnicodeDecodeError while reading log file {job['logfile']}\n")

                if job["failed"]:
                    self.oprint(f"\nThe following log for this failure is available:\n  {job['logfile']}\n")

                if self.bookends:
                    self.oprint(f">>> {job['name']} seq {job['seq']} >>>")

                log_processed = True

        elif job["cmdproc"]:
            if self.log_combine == "always" or (job["failed"] and self.log_combine == "fail"):
                if self.bookends:
                    self.oprint(f"<<< {job['name']}")

                for line in job["cmdproc"].stdout:
                    self.oprint(line, end="")
                    log_size += len(line)

                if "autoremove" in job:
                    for line in job["autoremove"].stdout:
                        self.oprint(line, end="")
                        log_size += len(line)
                    job["autoremove"] = None

                if self.bookends:
                    self.oprint(f">>> {job['name']}")

                log_processed = True

        if log_processed:
            self.flush()

            if self.debug:
                log_elapsed = time.time() - log_start
                log_rate = int(log_size / log_elapsed) if log_elapsed != 0 else 0
                log_data = ", {'/'.join(job['logfile'].split('/')[-2:])}" if job["logfile"] else ""
                DEBUG("WRITING LOG : {0:,} bytes in {1:0.3f} seconds ({2:,d} bytes/sec{3:})".format(log_size, log_elapsed, log_rate, log_data))

    # Log completion stats for job
    def writeJobLog(self, job):
        if self.joblogfile:
            print("{j[status]} {j[seq]:0{width}} {j[slot]} {j[task]} {j[name]} " \
                  "{j[utime]:.{prec}f} {j[stime]:.{prec}f} {j[cpu]} " \
                  "{j[elapsed]:.{prec}f} {j[start]:.{prec}f} {j[end]:.{prec}f} {0}" \
                  .format(job["logfile"] if job["logfile"] else "",
                          j=job, prec=4, width=self.twidth),
                  file=self.joblogfile, flush=True)

    # Remove any source code directories that are no longer required.
    # Output from the subprocess is either appended to the burst logfile
    # or is captured for later output to stdout (after the corresponding logfile).
    def autoRemovePackages(self, job):
        if self.autoremove:
            if self.debug:
                DEBUG(f"Cleaning Pkg: {job['name']} ({', '.join(self.generator.getPackageReferenceCounts(job))})")

            for pkg_name in self.generator.getPackagesToRemove(job):
                DEBUG(f"Removing Pkg: {pkg_name}")
                args = [f"{ROOT}/{SCRIPTS}/autoremove", pkg_name]
                if job["logfile"]:
                    with open(job["logfile"], "a") as logfile:
                        cmd = subprocess.run(args, cwd=ROOT,
                                             stdin=subprocess.PIPE, stdout=logfile, stderr=subprocess.STDOUT,
                                             universal_newlines=True, shell=False)
                else:
                    job["autoremove"] = subprocess.run(args, cwd=ROOT,
                                             stdin=subprocess.PIPE, capture_output=True,
                                             universal_newlines=True, shell=False)

                self.generator.removed(pkg_name)

    def show_status(self, status, task, data, p1=None, p2=None):
        p1 = (self.threadcount - self.generator.activeJobCount()) if p1 == None else p1
        p2 = self.generator.activeJobCount() if p2 == None else p2

        colored_status = f"{self.color_code[status]}{status:<4}\033[0m" if self.colors else f"{status:<4}"

        self.eprint("%s[%0*d/%0*d] [%s] %-7s %s" % \
            (self.progress_glitch_fix, self.twidth, p1, self.twidth, p2, colored_status, task, data))

    def stopProcesses(self):
        if self.processes:
            for process in self.processes:
                process.stop()
            self.processes = None

    def cleanup(self):
        self.clearProgress()
        self.flush()
        if self.original_resize_handler != None:
            signal.signal(signal.SIGWINCH, self.original_resize_handler)
        self.stopProcesses()

    def flush(self):
        if self.stdout_dirty:
            sys.stdout.flush()
            self.stdout_dirty = False

        if self.stderr_dirty:
            sys.stderr.flush()
            self.stderr_dirty = False

    def oprint(self, *args, flush=False, **kwargs):
        if self.progress_dirty:
            self.clearProgress()

        if self.stderr_dirty:
            sys.stderr.flush()
            self.stderr_dirty = False

        print(*args, **kwargs, file=sys.stdout, flush=flush)
        self.stdout_dirty = not flush

    def eprint(self, *args, flush=False, isProgress=False, **kwargs):
        if self.stdout_dirty:
            sys.stdout.flush()
            self.stdout_dirty = False

        if not isProgress and self.progress_dirty:
            self.clearProgress()

        print(*args, **kwargs, file=sys.stderr, flush=flush)
        self.stderr_dirty = not flush

    def getLoad(self):
        return open("/proc/loadavg", "r").readline().split()

    def getMemory(self):
        return dict((i.split()[0].rstrip(':'),int(i.split()[1])) for i in open("/proc/meminfo", "r").readlines())

    def getTerminalSize(self, signum = None, frame = None):
        h, w, hp, wp = struct.unpack('HHHH',
                                     fcntl.ioctl(sys.stderr.fileno(), termios.TIOCGWINSZ,
                                                 struct.pack('HHHH', 0, 0, 0, 0)))
        self.rows = h
        self.columns = w

    def secs2hms(self, seconds):
        min, sec = divmod(seconds, 60)
        hour, min = divmod(min, 60)
        return f"{hour:02.0f}:{min:02.0f}:{sec:02.0f}"

def DEBUG(msg):
    if DEBUG_LOG:
        print(f"{datetime.datetime.now()}: {msg}", file=DEBUG_LOG, flush=True)

parser = argparse.ArgumentParser(description="Run processes to build the specified JSON plan", \
                                 formatter_class=lambda prog: argparse.HelpFormatter(prog,max_help_position=25,width=90))

parser.add_argument("--max-procs", required=False, default="100%", \
                    help="Maximum number of processes to use. 0 is unlimited. Can be expressed as " \
                         "a percentage, for example 50%% (of $(nproc)). Default is 100%%.")

parser.add_argument("--plan", metavar="FILE", default="-", \
                    help="JSON formatted plan to be processed (default is to read from stdin).")

parser.add_argument("--joblog", metavar="FILE", default=None, \
                    help="File into which job completion information will be written.")

parser.add_argument("--loadstats", metavar="FILE", default=None, \
                    help="File into which load average and memory statistics will be written.")

parser.add_argument("--stats-interval", metavar="SECONDS", type=int, default=60, \
                    help="Sampling interval in seconds for --loadstats. Default is 60.")

group =  parser.add_mutually_exclusive_group()
group.add_argument("--log-burst", action="store_true", default=True, \
                    help="Burst job output into individual log files. This is the default.")
group.add_argument("--no-log-burst", action="store_false", dest="log_burst", \
                    help="Disable --log-burst, job output is only written to stdout.")

parser.add_argument("--log-combine", choices=["always", "never", "fail"], default="always", \
                    help='Choose when to send job output to stdout. "fail" will send to stdout the ' \
                         'log of failed jobs only, while "never" will not send any logs to stdout. ' \
                         'Default is "always".')

group =  parser.add_mutually_exclusive_group()
group.add_argument("--with-bookends", action="store_true", default=True, \
                    help="Top & tail combined logs with searchable markers. Default is enabled.")
group.add_argument("--without-bookends", action="store_false", dest="with_bookends", \
                    help="Disable --with-bookends")

group =  parser.add_mutually_exclusive_group()
group.add_argument("--halt-on-error", action="store_true", default=True, \
                    help="Halt on first build failure. This is the default.")
group.add_argument("--continue-on-error", action="store_false", dest="halt_on_error", \
                    help="Disable --halt-on-error and continue building.")

group =  parser.add_mutually_exclusive_group()
group.add_argument("--fail-immediately", action="store_true", default=True, \
                    help="With --halt-on-error, the build can either fail immediately or only after all " \
                         "other active jobs have finished. Default is to fail immediately.")
group.add_argument("--fail-after-active", action="store_false", dest="fail_immediately", \
                    help="With --halt-on-error, when an error occurs fail after all other active jobs have finished.")

parser.add_argument("--auto-remove", action="store_true", default=False, \
                    help="Automatically remove redundant source code directories. Default is disabled.")

parser.add_argument("--progress", action="store_true", default=False, \
                    help="Display progress information. Default is disabled")

parser.add_argument("--verbose", action="store_true", default=False, \
                    help="Output verbose information to stderr.")

parser.add_argument("--debug", action="store_true", default=False, \
                    help="Enable debug information.")

parser.add_argument("--colors", choices=["always", "never", "auto"], default="auto", \
                    help="Color code status (DONE, FAIL, etc) labels.")

args = parser.parse_args()

#---------------------------

ROOT = os.environ.get("ROOT", os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
SCRIPTS = os.environ.get("SCRIPTS", "scripts")
THREAD_CONTROL = os.environ["THREAD_CONTROL"]

if args.debug:
    debug_log = f"{THREAD_CONTROL}/debug.log"
    DEBUG_LOG = open(debug_log, "w")
    print(f"Debug information is being written to: {debug_log}\n", file=sys.stderr, flush=True)
else:
    DEBUG_LOG = None

with open(f"{THREAD_CONTROL}/parallel.pid", "w") as pid:
    print(f"{os.getpid()}", file=pid)

try:
    builder = Builder(args.max_procs, args.plan, args.joblog, args.loadstats, args.stats_interval, \
                      haltonerror=args.halt_on_error, failimmediately=args.fail_immediately, \
                      log_burst=args.log_burst, log_combine=args.log_combine, bookends=args.with_bookends, \
                      autoremove=args.auto_remove, colors=args.colors, progress=args.progress, \
                      debug=args.debug, verbose=args.verbose)

    result = builder.build()

    if DEBUG_LOG:
        DEBUG_LOG.close()

    sys.exit(0 if result else 1)
except (KeyboardInterrupt, SystemExit) as e:
    if builder:
        builder.cleanup()

    if type(e) == SystemExit:
        sys.exit(int(str(e)))
    else:
        sys.exit(1)

