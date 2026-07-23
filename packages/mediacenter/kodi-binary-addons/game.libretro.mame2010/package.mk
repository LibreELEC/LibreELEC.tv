# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2010"
PKG_VERSION="0.139.0.32-Omega"
PKG_SHA256="711f8739364346456af6d81461da9ae554f1b1d74d1d5dcc1ed256ecda4a4a5b"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2010"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2010/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2010"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2010: MAME emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
