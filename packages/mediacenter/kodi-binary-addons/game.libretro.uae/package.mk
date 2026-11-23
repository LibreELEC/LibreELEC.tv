# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.uae"
PKG_VERSION="5.3.1.106-Piers"
PKG_SHA256="46c6659c893031bf430efd68dbbc417d876407c916e57522bab0280f9fab11f4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.uae"
PKG_URL="https://github.com/kodi-game/game.libretro.uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-uae"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.uae: uae emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
