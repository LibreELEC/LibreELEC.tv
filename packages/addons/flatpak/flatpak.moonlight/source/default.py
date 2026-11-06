# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

from flatpakhelper.addon import FlatpakAddon
import xbmcaddon

addon = xbmcaddon.Addon()

def get_audio_device() -> str | None:
    if not addon.getSettingBool('customaudio'):
        return None
    
    audiodev = addon.getSettingString('customaudiodevice')
    if audiodev is None:
        return None
    audiodev = audiodev.strip()
    if audiodev.strip() == '':
        return None
    return audiodev

def get_audio_channels() -> int | None:
    channels = addon.getSettingInt('audiochannels')
    if channels == 0:
        return None
    return channels

flatpak = FlatpakAddon(addon=addon, appid="com.moonlight_stream.Moonlight")
flatpak.start(pulseaudio_channels=get_audio_channels(), audiodevice=get_audio_device())
