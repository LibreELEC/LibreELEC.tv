# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2000"
PKG_VERSION="0.37.0.40-Omega"
PKG_SHA256="3a67d8eb2c61d5e1f81f113e898cb5a543ab157b2222c871668c20b39871b897"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2000"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2000/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2000"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2000: MAME 2000 emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
