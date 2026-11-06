# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import os
import subprocess

import externalhelper.utils as eh
import xbmc


class Flatpak:
    def __init__(self, flatpak_exe: str = 'flatpak', flatpak_run: str = 'flatpak'):
        self.flatpak = flatpak_exe
        self.flatpak_run = flatpak_run
        self.target = '--system'
        self.icondir = '/storage/flatpak/exports/share/icons/hicolor'

    def _run(self, args: list):
        cmd = [self.flatpak, *args]
        return subprocess.run(cmd, capture_output=True, text=True)

    def _run_dbus(self, args: list):
        cmd = ['dbus-run-session', '--', self.flatpak, *args]
        return subprocess.run(cmd, capture_output=True, text=True)

    def install_remote(self, remote: str, url: str) -> bool:
        result = self._run(['remote-add', self.target, '--if-not-exists', remote, url])
        if result.returncode != 0:
            xbmc.log(f'failed to install repository: {result.stderr.strip()}', xbmc.LOGERROR)
        return result.returncode == 0

    def install(self, appid: str, remote: str, reinstall: bool = False) -> bool:
        if appid is None:
            xbmc.log('install: appid needs to be set')
            return False

        if remote is None:
            xbmc.log('install: remote needs to be set')
            return False

        args = ['install', self.target, '--noninteractive', '-y']
        if reinstall:
            args.append('--reinstall')
        args.extend([remote, appid])

        result = self._run_dbus(args)
        if result.returncode != 0:
            xbmc.log(f'failed to install {appid} from {remote}: {result.stderr.strip()}', xbmc.LOGERROR)
        else:
            xbmc.log(f'installed {appid}')
        return result.returncode == 0

    def uninstall_unused(self) -> bool:
        result = self._run_dbus(['uninstall', self.target, '--noninteractive', '-y', '--unused'])
        if result.returncode != 0:
            xbmc.log(f'failed to uninstall unused: {result.stderr.strip()}', xbmc.LOGERROR)
        else:
            xbmc.log('uninstall unused succeeded')
        return result.returncode == 0

    def uninstall(self, appid: str, delete_data: bool = False) -> bool:
        if appid is None:
            xbmc.log('uninstall requires appid to be set')
            return False

        args = ['uninstall', self.target, '--noninteractive', '-y']
        if delete_data:
            args.append('--delete-data')
        args.append(appid)

        result = self._run_dbus(args)
        if result.returncode != 0:
            xbmc.log(f'failed to uninstall {appid}: {result.stderr.strip()}', xbmc.LOGERROR)
            return False
        else:
            xbmc.log(f'uninstall {appid} succeeded')

        return result.returncode == 0

    def update(self, appid: str | None = None) -> bool:
        args = ['update', self.target, '--noninteractive', '-y']

        if appid is not None:
            args.append(appid)

        result = self._run_dbus(args)
        if result.returncode != 0:
            if appid is None:
                xbmc.log(f'failed to update all applications: {result.stderr.strip()}', xbmc.LOGERROR)
            else:
                xbmc.log(f'failed to update {appid}: {result.stderr.strip()}', xbmc.LOGERROR)
            return False
        else:
            if appid is None:
                xbmc.log('update all applications succeeded')
            else:
                xbmc.log(f'updated {appid}')

        return result.returncode == 0

    def get_commit(self, appid: str, quiet: bool = False) -> str | None:
        result = self._run(['info', self.target, '-c', appid])
        if result.returncode != 0:
            if not quiet:
                xbmc.log(f'failed to check commit of {appid}: {result.stderr.strip()}')
            return None

        commit = result.stdout.strip()
        return commit

    def is_installed(self, appid: str) -> bool:
        return self.get_commit(appid=appid, quiet=True) is not None

    def get_remote_commit(self, appid: str, remote: str) -> str | None:
        result = self._run(['remote-info', self.target, '-c', remote, appid])
        if result.returncode != 0:
            xbmc.log(f'failed to get remote info of {appid} form {remote}: {result.stderr.strip()}', xbmc.LOGERROR)
            return None

        commit = result.stdout.strip()
        return commit

    def get_installed_applications(self) -> list | None:
        result = self._run(
            ['list', self.target, '--app', '--columns=name,application,version,origin,description,active']
        )
        if result.returncode != 0:
            xbmc.log(f'failed to get list of installed applications: {result.stderr}', xbmc.LOGERROR)
            return None

        apps = result.stdout.strip().split('\n')
        applist = []
        for a in apps:
            xbmc.log(f'installed app: {a!r}')
            c = a.split('\t')
            if len(c) == 6:
                applist.append(
                    {'name': c[0], 'appid': c[1], 'version': c[2], 'origin': c[3], 'description': c[4], 'commit': c[5]}
                )

        return applist

    def get_application_info(self, appid: str) -> dict | None:
        apps = self.get_installed_applications()
        if apps is None:
            return None
        app = list(filter(lambda a: a['appid'] == appid, apps))
        if len(app) == 0:
            xbmc.log(f'cannot get info of {appid}')
            return None
        if len(app) > 1:
            xbmc.log(f'found {len(app)} applications matching {appid} but expected one', xbmc.LOGWARNING)
        return app[0]

    def get_application_name(self, appid: str) -> str | None:
        info = self.get_application_info(appid)
        if info is None:
            return None
        return info['name']

    def start(
        self,
        appid: str,
        args: list | None = None,
        env: dict | None = None,
        flatpak_args: list | None = None,
        run_env: dict | None = None,
        wayland: bool = True,
        pulseaudio: bool = True,
        pulseaudio_channels: int | None = None,
        audiodevice: str | None = None,
        displayconfig: str | None = None,
    ) -> bool:

        info = self.get_application_info(appid)
        if info is None:
            xbmc.log(f'start: failed to get app info of {appid}')
            return False

        name = info['name']

        runargs = [self.target]
        if env is not None:
            for k, v in env.items():
                runargs.append(f'--env={k}={v}')

        if flatpak_args is not None:
            runargs.extend(flatpak_args)

        runargs.append(appid)
        if args is not None:
            runargs.extend(args)

        flatpak_run_env = {}
        if pulseaudio:
            flatpak_run_env['KODI_FLATPAK_PULSEAUDIO'] = 'yes'
            if pulseaudio_channels is not None:
                flatpak_run_env['KODI_FLATPAK_PULSEAUDIO_CHANNELS'] = str(pulseaudio_channels)
        else:
            flatpak_run_env['KODI_FLATPAK_PULSEAUDIO'] = 'no'

        if run_env is not None:
            flatpak_run_env.update(run_env)

        return eh.run_external_program(
            executable=self.flatpak_run,
            args=runargs,
            env=flatpak_run_env,
            name=name,
            wayland=wayland,
            audiodevice=audiodevice,
            displayconfig=displayconfig,
        )

    def find_application_icon(self, appid: str) -> str | None:
        for i in ['512x512', '256x256', '128x128', '64x64', '48x48', '32x32']:
            icon = os.path.join(self.icondir, i, 'apps', appid + '.png')
            if os.path.isfile(icon):
                return icon

        return None
