# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bk"
PKG_VERSION="1.0.0.34-Omega"
PKG_SHA256="3888fa12dbbbf18bb652a9cd2d5b2165d1626a0170a63baee4eacb82d918c0dd"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.bk"
PKG_URL="https://github.com/kodi-game/game.libretro.bk/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bk"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bk: bk for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
