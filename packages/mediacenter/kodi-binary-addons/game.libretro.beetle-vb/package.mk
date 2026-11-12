# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-vb"
PKG_VERSION="1.31.0.48-Piers"
PKG_SHA256="bfa73c5884ffbdbc023a4a213c7561f3bd57c7326f12b9d02f54d640514d596d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-vb"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-vb/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-vb"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-vb: Beetle vb for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
