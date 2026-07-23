# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.sameboy"
PKG_VERSION="0.15.4.47-Omega"
PKG_SHA256="89507471c0b0cb10d18af3c16735f9efc7465490424f95de3d704be643442c40"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/kodi-game/game.libretro.sameboy"
PKG_URL="https://github.com/kodi-game/game.libretro.sameboy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-sameboy"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.sameboy: SameBoy emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
