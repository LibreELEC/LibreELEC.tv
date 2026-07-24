# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.virtualjaguar"
PKG_VERSION="2.2.0.47-Omega"
PKG_SHA256="9f07b0505d626477ee911a9c9af6fd6839b41e3c53157a3ba1729f0c2ca8b20e"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.virtualjaguar"
PKG_URL="https://github.com/kodi-game/game.libretro.virtualjaguar/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-virtualjaguar"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.virtualjaguar: VirtualJaguar for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
