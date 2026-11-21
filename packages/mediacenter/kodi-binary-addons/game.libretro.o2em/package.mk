# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.o2em"
PKG_VERSION="1.18.0.59-Piers"
PKG_SHA256="abff85c566e449edff3ec86060d4525f4e516e3d56033f7eb98da1f1baf87c08"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Artistic-2.0"
PKG_SITE="https://github.com/kodi-game/game.libretro.o2em"
PKG_URL="https://github.com/kodi-game/game.libretro.o2em/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-o2em"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.o2em: o2em for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
