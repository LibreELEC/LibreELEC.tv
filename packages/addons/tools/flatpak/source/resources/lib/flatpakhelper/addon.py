# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import externalhelper.utils as eh
import xbmc
import xbmcaddon

from .gui import FlatpakGui


class FlatpakAddon:
    def __init__(
        self,
        addon: xbmcaddon.Addon,
        appid: str,
        remote: str = 'flathub',
        remote_url: str = 'https://dl.flathub.org/repo/flathub.flatpakrepo',
        display_settings: bool = True,
        audio_settings: bool = False,
    ):

        self.calling_addon = addon
        self.name = addon.getAddonInfo('name')

        self.appid = appid
        self.remote = remote
        self.remote_url = remote_url
        self.display_settings = display_settings
        self.audio_settings = audio_settings

        self.gui = FlatpakGui()

    def get_display_config_setting(self) -> str | None:
        settings = self.calling_addon.getSettings()

        try:
            if not settings.getBool('displayoverride'):
                return None
        except TypeError:
            return None

        try:
            config = settings.getInt('displayconfig')
        except TypeError:
            return None

        match config:
            case 0:
                return eh.DISPLAYCONFIG_DEFAULT
            case 1:
                return eh.DISPLAYCONFIG_4K
            case 2:
                return eh.DISPLAYCONFIG_HD
            case 3:
                return eh.DISPLAYCONFIG_720
            case 999:
                try:
                    custom = settings.getString('customdisplayconfig').strip()
                except TypeError:
                    return None

                if custom == '':
                    return None
                else:
                    return custom
            case _:
                xbmc.log(f'invalid displayconfig {config}', xbmc.LOGERROR)

        return None

    def get_audio_device_setting(self) -> str | None:
        settings = self.calling_addon.getSettings()
        try:
            if not settings.getBool('customaudio'):
                return None
        except TypeError:
            return None
    
        try:
            audiodev = settings.getString('customaudiodevice').strip()
        except TypeError:
            return None

        if audiodev == '':
            return None
        else:
            return audiodev

    def get_audio_channels_setting(self) -> int | None:
        try:
            channels = self.calling_addon.getSettings().getInt('audiochannels')
        except TypeError:
            return None

        if channels == 0:
            return None
        else:
            return channels

    def start(
        self,
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

        if displayconfig is None and self.display_settings:
            displayconfig = self.get_display_config_setting()

        if pulseaudio_channels is None and self.audio_settings:
            pulseaudio_channels = self.get_audio_channels_setting()

        if audiodevice is None and self.audio_settings:
            audiodevice = self.get_audio_device_setting()

        return self.gui.start(
            appid=self.appid,
            name=self.name,
            remote=self.remote,
            remote_url=self.remote_url,
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
