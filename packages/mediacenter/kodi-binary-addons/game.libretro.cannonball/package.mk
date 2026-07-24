# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.cannonball"
PKG_VERSION="0.0.1.40-Omega"
PKG_SHA256="2a02b908783313856a2adbebcbf1825ec76be2b9cdd26135f6616fe270e75fde"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.cannonball"
PKG_URL="https://github.com/kodi-game/game.libretro.cannonball/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-cannonball"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.cannonball: Cannonball: An Enhanced OutRun Engine for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
