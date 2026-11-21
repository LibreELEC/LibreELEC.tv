# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2003_plus"
PKG_VERSION="0.0.1.105-Piers"
PKG_SHA256="f2bb37ffa49e8d78d408910d3dd8e98ca24eed74c6ceb64c6cd38cf5581dc905"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2003_plus"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2003_plus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2003_plus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2003_plus: MAME 2003 Plus emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
