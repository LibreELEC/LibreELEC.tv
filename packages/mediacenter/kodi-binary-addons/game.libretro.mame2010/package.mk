# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2010"
PKG_VERSION="0.139.0.40-Piers"
PKG_SHA256="b141e2c5459feff23829410bf83702993b969f79f5179fa9ece63c1f6deda41e"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2010"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2010/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2010"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2010: MAME emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
