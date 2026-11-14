# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.virtualjaguar"
PKG_VERSION="3.10.0.60-Piers"
PKG_SHA256="7517a30eba1f8feaea08ddd19de098decb5d2dadb2d21cdb983a8befa07cc554"
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
