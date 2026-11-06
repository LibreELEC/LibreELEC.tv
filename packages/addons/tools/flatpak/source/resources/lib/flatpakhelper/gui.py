# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import os
from contextlib import contextmanager

import xbmc
import xbmcaddon
import xbmcgui

from .flatpak import Flatpak

ADDON_ID = 'tools.flatpak'


class FlatpakGui:
    def __init__(self):
        self.addon = xbmcaddon.Addon(ADDON_ID)
        self.addon_name = self.addon.getAddonInfo('name')
        self.addon_path = self.addon.getAddonInfo('path')
        self.addon_icon = self.addon.getAddonInfo('icon')
        self.flatpak_icon = os.path.join(self.addon_path, 'resources', 'media', 'icon.png')

        flatpak_exe = os.path.join(self.addon_path, 'bin', 'flatpak')
        flatpak_run = os.path.join(self.addon_path, 'bin', 'flatpak-run-wrapper')

        self.flatpak = Flatpak(flatpak_exe=flatpak_exe, flatpak_run=flatpak_run)

    @contextmanager
    def progress_dialog(self, msg: str):
        progress = xbmcgui.DialogProgress()
        progress.create(self.addon_name, msg)
        try:
            yield
        finally:
            progress.close()

    def toast(self, msg: str) -> None:
        xbmcgui.Dialog().notification(heading=self.addon_name, message=msg, icon=xbmcgui.NOTIFICATION_INFO, time=5000)

    def toast_error(self, msg: str) -> None:
        xbmcgui.Dialog().notification(heading=self.addon_name, message=msg, icon=xbmcgui.NOTIFICATION_ERROR, time=5000)

    def ls(self, id: int) -> str:
        return self.addon.getLocalizedString(id)

    def confirm_and_install(self, appid: str, remote: str, name: str, reinstall: bool = False) -> bool:
        if reinstall:
            str = self.ls(30012).format(name=name)
        else:
            str = self.ls(30000).format(name=name)
        ok = xbmcgui.Dialog().yesno(self.addon_name, str)
        if not ok:
            return False

        ok = False
        with self.progress_dialog(self.ls(30018).format(name=name)):
            ok = self.flatpak.install(appid, remote)

        if not ok:
            self.toast_error(self.ls(30001).format(name=name))
        else:
            self.toast(self.ls(30022).format(name=name))

        return ok

    def check_for_updates(self, appid: str) -> bool:
        info = self.flatpak.get_application_info(appid)
        if info is None:
            self.toast_error(self.ls(30002).format(name=appid))
            return False

        name = info['name']

        current_commit = self.flatpak.get_commit(appid)
        if current_commit is None:
            self.toast_error(self.ls(30002).format(name=name))
            return False

        repo_commit = self.flatpak.get_remote_commit(appid=appid, remote=info['origin'])

        if repo_commit is None:
            self.toast_error(self.ls(30003))
            return False

        if current_commit == repo_commit:
            self.toast(self.ls(30004).format(name=name))
            return True

        ok = xbmcgui.Dialog().yesno(self.addon_name, self.ls(30005).format(name=name))
        if not ok:
            return True

        with self.progress_dialog(self.ls(30019).format(name=name)):
            ok = self.flatpak.update(appid)
            if ok:
                ok = self.flatpak.uninstall_unused()

        if not ok:
            self.toast_error(self.ls(30006).format(name=name))
        else:
            self.toast(self.ls(30007).format(name=name))

        return ok

    def confirm_and_uninstall(self, appid: str) -> bool:
        name = self.flatpak.get_application_name(appid)
        if name is None:
            self.toast_error(self.ls(30002).format(name=appid))
            return False

        ok = xbmcgui.Dialog().yesno(self.addon_name, self.ls(30008).format(name=name))
        if not ok:
            return False

        delete_data = xbmcgui.Dialog().yesno(self.addon_name, self.ls(30009).format(name=name))

        with self.progress_dialog(self.ls(30020).format(name=name)):
            ok = self.flatpak.uninstall(appid, delete_data=delete_data)
            if ok:
                ok = self.flatpak.uninstall_unused()

        if not ok:
            self.toast_error(self.ls(30010).format(name=name))
        else:
            self.toast(self.ls(30011).format(name=name))

        return ok

    def install_repo(self, remote: str, url: str) -> bool:
        ok = self.flatpak.install_remote(remote, url)
        if not ok:
            self.toast_error(self.ls(30013).format(remote=remote))
        return ok

    def start(
        self,
        appid: str,
        name: str | None = None,
        remote: str | None = None,
        remote_url: str | None = None,
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

        if not self.flatpak.get_commit(appid):
            if name is None:
                name = appid

            if remote is None or remote_url is None:
                xbmc.log('missing remote', xbmc.LOGERROR)
                self.toast_error(self.ls(30001).format(name=name))
                return False

            ok = self.install_repo(remote, remote_url)
            if not ok:
                return False

            ok = self.confirm_and_install(appid, remote, name)
            if not ok:
                return False

        return self.flatpak.start(
            appid=appid,
            args=args,
            env=env,
            flatpak_args=flatpak_args,
            run_env=run_env,
            wayland=wayland,
            pulseaudio=pulseaudio,
            pulseaudio_channels=pulseaudio_channels,
            audiodevice=audiodevice,
            displayconfig=displayconfig,
        )

    def show_info(self, appid: str) -> None:
        info = self.flatpak.get_application_info(appid)
        if info is None:
            self.toast_error(self.ls(30002).format(name=appid))
            return

        xbmcgui.Dialog().ok(info.get('name'), self.ls(30014).format(**info))

    def confirm_and_update_all(self) -> bool:
        ok = xbmcgui.Dialog().yesno(self.addon_name, self.ls(30015))
        if not ok:
            return True

        ok = False
        with self.progress_dialog(self.ls(30021)):
            ok = self.flatpak.update(appid=None)
            if ok:
                ok = self.flatpak.uninstall_unused()

        if not ok:
            self.toast_error(self.ls(30016))
        else:
            self.toast(self.ls(30017))

        return ok
