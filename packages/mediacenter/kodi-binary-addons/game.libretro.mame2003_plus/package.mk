# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2003_plus"
PKG_VERSION="0.0.1.102-Omega"
PKG_SHA256="2f49f5bcbb71f03f1d0d0a031ec7930680f1836356441cad72d1f70fba0d85de"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2003_plus"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2003_plus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2003_plus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2003_plus: MAME 2003 Plus emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
