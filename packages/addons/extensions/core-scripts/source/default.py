# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

import os
import shlex
import shutil
import subprocess

import xbmc
import xbmcaddon


ADDON_DIR = xbmcaddon.Addon().getAddonInfo('path')
EXTENSION_ROOT = '/storage/.config/extensions/core-scripts'


# Announce ourselves
xbmc.log('LE-Core-Scripts: Loading core scripts...', xbmc.LOGINFO)
# make directories in bind mounted filesystem for persistent storage
if not os.path.exists(f'{EXTENSION_ROOT}/usr/bin'):
    os.makedirs(f'{EXTENSION_ROOT}/usr/bin')
if not os.path.exists(f'{EXTENSION_ROOT}/usr/lib/extension-release.d'):
    os.makedirs(f'{EXTENSION_ROOT}/usr/lib/extension-release.d')

# link files from addon bin into filesystem
for file in os.listdir(f'{ADDON_DIR}/bin/'):
    if not os.path.exists(f'{EXTENSION_ROOT}/usr/bin/{file}'):
        os.symlink(f'{ADDON_DIR}/bin/{file}', f'{EXTENSION_ROOT}/usr/bin/{file}')

# copy systemd-sysext validation file into place (link won't be followed)
if not os.path.exists(f'{EXTENSION_ROOT}/usr/lib/extension-release.d/extension-release.core-scripts'):
    shutil.copy2(f'{ADDON_DIR}/lib/extension-release.core-scripts', f'{EXTENSION_ROOT}/usr/lib/extension-release.d/extension-release.core-scripts')

# refresh systemd-sysext
try:
    subprocess.run(shlex.split('systemd-sysext refresh'), check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
except subprocess.CalledProcessError as e:
    xbmc.log(f'LibreELEC-Core-Scripts: ERROR: Command failed: systemd-sysext', xbmc.LOGERROR)
    xbmc.log(f'LibreELEC-Core-Scripts: START COMMAND OUTPUT\n{e.stdout.decode()}\nEND COMMAND OUTPUT', xbmc.LOGERROR)
except FileNotFoundError:
    xbmc.log(f'LibreELEC-Core-Scripts: ERROR: Failed to find systemd-sysext', xbmc.LOGERROR)

# Finished
xbmc.log('LE-Core-Scripts: Core scripts loaded.', xbmc.LOGINFO)
