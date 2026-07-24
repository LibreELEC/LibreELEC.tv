# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.handy"
PKG_VERSION="0.97.0.47-Omega"
PKG_SHA256="6cfacfe4c541a88987ab95cfd2f32ac398000e9585c655ad69fd94040ce16f39"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/kodi-game/game.libretro.handy"
PKG_URL="https://github.com/kodi-game/game.libretro.handy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-handy"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.handy: handy for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
