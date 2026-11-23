# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.virtualjaguar"
PKG_VERSION="3.13.0.62-Piers"
PKG_SHA256="60c3f9e7fc57362c9a3bd92da554a233a1bc3491cf8e9b7d89e134ad1772f59a"
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
