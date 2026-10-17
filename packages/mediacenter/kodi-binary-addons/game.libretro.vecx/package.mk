# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vecx"
PKG_VERSION="1.2.0.53-Omega"
PKG_SHA256="671917d56711ab3c881a04c21cc314245330ccccd7b515952c4805873adffe72"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.vecx"
PKG_URL="https://github.com/kodi-game/game.libretro.vecx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vecx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vecx: vecx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
