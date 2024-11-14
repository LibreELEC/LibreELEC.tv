import socket
import subprocess
import threading

import utils


class Librespot:
    @utils.logged_method
    def __init__(self, target, backend, device):
        self._target = target
        name = utils.get_setting("name").format(socket.gethostname())
        self._command = [
            "librespot",
            "--backend", backend,
            "--bitrate", "320",
            "--device", device,
            "--device-type", "tv",
            "--disable-audio-cache",
            "--disable-credential-cache",
            "--name", name,
            "--onevent", target.event_handler.get_onevent(),
            "--quiet",
        ]
        self._failures = 0
        self._max_failures = 5
        self._librespot = None
        self._get_librespot = self._schedule_librespot()

    @utils.logged_method
    def __enter__(self):
        return self

    @utils.logged_method
    def __exit__(self, *_):
        self._get_librespot.close()

    def _schedule_librespot(self):
        while self._failures < self._max_failures:
            with subprocess.Popen(
                self._command, stderr=subprocess.PIPE, text=True
            ) as self._librespot:
                threading.Thread(target=self._monitor_librespot).start()
                try:
                    yield
                finally:
                    self._librespot.terminate()
        utils.call_if_has(self._target, "on_librespot_broken")
        utils.log("Librespot crashed too many times", True)
        self._librespot = None
        while True:
            yield

    def _monitor_librespot(self):
        self._target.on_librespot_started()
        with self._librespot as librespot:
            for line in librespot.stderr:
                utils.log(line.rstrip())
        self._target.on_librespot_stopped()
        if librespot.returncode < 0:
            self._failures = 0
        else:
            self._failures += 1
            next(self._get_librespot)

    @utils.logged_method
    def restart(self):
        next(self._get_librespot)

    @utils.logged_method
    def start(self):
        if self._librespot is None or self._librespot.poll() is not None:
            next(self._get_librespot)

    @utils.logged_method
    def stop(self):
        if self._librespot is not None:
            self._librespot.terminate()
