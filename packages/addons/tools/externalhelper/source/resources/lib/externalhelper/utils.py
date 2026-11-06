# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import json
import os
import subprocess

import xbmc
import xbmcaddon
import xbmcgui

ADDON_ID = 'tools.externalhelper'
addon = xbmcaddon.Addon(ADDON_ID)
settings = addon.getSettings()
RUN_EXTERNAL = os.path.join(addon.getAddonInfo('path'), 'bin', 'kodi-run-external')

DISPLAYCONFIG_DEFAULT = 'default'
DISPLAYCONFIG_4K = '3840x2160'
DISPLAYCONFIG_HD = '1920x1080'
DISPLAYCONFIG_720 = '1280x720'

def get_kodi_setting(setting: str):
    query = '{"jsonrpc":"2.0", "method":"Settings.GetSettingValue", "params":{"setting":"' + setting + '"}, "id":1}'

    rpc_result = xbmc.executeJSONRPC(query)
    json_result = json.loads(rpc_result)

    if 'result' in json_result and 'value' in json_result['result']:
        return json_result['result']['value']
    else:
        return None


def get_confirm_start_setting() -> bool:
    return settings.getBool('confirmstart')


def get_display_config_setting() -> str | None:
    config = settings.getInt('displayconfig')
    match config:
        case 0:
            return DISPLAYCONFIG_DEFAULT
        case 1:
            return DISPLAYCONFIG_4K
        case 2:
            return DISPLAYCONFIG_HD
        case 3:
            return DISPLAYCONFIG_720
        case 999:
            custom = settings.getString('customdisplayconfig').strip()
            if custom == '':
                return None
            else:
                return custom
        case _:
            xbmc.log(f'invalid displayconfig {config}', xbmc.LOGERROR)
            return None


def get_kodi_keyboard_layout() -> str | None:
    return get_kodi_setting('input.libinputkeyboardlayout')


def translate_kodi_audio_device(device: str | None) -> str | None:
    if device is None:
        return None

    device = device.split('|')[0]

    if device.startswith('PULSE:') or device.startswith('PIPEWIRE:'):
        return device
    elif device.startswith('ALSA:'):
        alsadev = device[5:]
        if alsadev == '@' or alsadev == '@:':
            return 'ALSA:sysdefault'
        elif alsadev.startswith('@:'):
            devpos = alsadev.find(',DEV=')
            if devpos >= 0:
                dev = alsadev[2:devpos]
            else:
                dev = alsadev[2:]
            if len(dev) > 0:
                return f'ALSA:sysdefault:{dev}'
            else:
                return 'ALSA:sysdefault'
        else:
            return device
    else:
        return 'ALSA:sysdefault'


def get_kodi_audio_device() -> str | None:
    device = get_kodi_setting('audiooutput.audiodevice')
    translated_device = translate_kodi_audio_device(device)
    xbmc.log(f'audio device {device} translated to {translated_device}', xbmc.LOGDEBUG)
    return translated_device


def get_audio_device() -> str | None:
    if settings.getBool('customaudio'):
        audiodev = settings.getString('customaudiodevice')
        if audiodev is None:
            return None
        audiodev = audiodev.strip()
        if audiodev.strip() == '':
            return None
        xbmc.log(f'using custom audio device {audiodev}')
        return audiodev
    else:
        return get_kodi_audio_device()


def run_external_program(
    executable: str,
    args: list | None = None,
    env: dict | None = None,
    name: str = '',
    wayland: bool = True,
    audiodevice: str | None = None,
    displayconfig: str | None = None,
) -> bool:
    addon = xbmcaddon.Addon(ADDON_ID)

    if get_confirm_start_setting():
        str = addon.getLocalizedString(30000).format(name=name)
        ok = xbmcgui.Dialog().yesno(name, str)
        if not ok:
            return False

    # try to determine keyboard layout
    layout = get_kodi_keyboard_layout()
    if audiodevice is None:
        audiodevice = get_audio_device()
    if displayconfig is None:
        displayconfig = get_display_config_setting()

    environment = {}

    if displayconfig is not None:
        environment['KODI_DISPLAY_CONFIG'] = displayconfig
    if layout is not None:
        environment['KODI_KEYBOARD_LAYOUT'] = layout
    if audiodevice is not None:
        environment['KODI_AUDIO_DEVICE'] = audiodevice
    if wayland:
        environment['KODI_EXTERNAL_SESSION'] = 'wayland'
    else:
        environment['KODI_EXTERNAL_SESSION'] = 'plain'

    if env is not None:
        environment.update(env)

    cmd = ['systemd-run', '-u', 'kodi-run-external']

    for k, v in environment.items():
        cmd.append(f'-E{k}={v}')

    cmd.append(RUN_EXTERNAL)
    cmd.append(executable)

    if args is not None:
        cmd.extend(args)

    xbmc.log(f'starting {cmd!r}')

    result = subprocess.run(cmd, shell=False, close_fds=True, capture_output=True, text=True)
    if result.returncode != 0:
        xbmc.log(f'failed to start {cmd!r}: {result.stderr.strip()}', xbmc.LOGERROR)
    return result.returncode == 0
