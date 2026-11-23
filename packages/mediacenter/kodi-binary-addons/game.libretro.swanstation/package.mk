# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.swanstation"
PKG_VERSION="1.0.0.44-Piers"
PKG_SHA256="8c1c84f1d7bc1f31791c4da49d721e1816f672d045429e6d8bd39d777fc200e0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.swanstation"
PKG_URL="https://github.com/kodi-game/game.libretro.swanstation/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-swanstation"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.swanstation: SwanStation for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
