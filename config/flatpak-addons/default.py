# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

import xbmcaddon
from flatpakhelper.addon import FlatpakAddon

flatpak = FlatpakAddon(addon=xbmcaddon.Addon(), appid="@APPID@"@AUDIO_SETTINGS@)
flatpak.start(@START_ARGS@)
