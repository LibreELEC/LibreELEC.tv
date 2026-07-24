# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.swanstation"
PKG_VERSION="1.0.0.35-Omega"
PKG_SHA256="54d5dbf1134d9feefb503cd0b3050456789262285fe67f16df6beb52fb862632"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.swanstation"
PKG_URL="https://github.com/kodi-game/game.libretro.swanstation/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-swanstation"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.swanstation: SwanStation for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
