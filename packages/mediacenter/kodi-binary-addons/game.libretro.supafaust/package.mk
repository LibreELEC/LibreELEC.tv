# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.supafaust"
PKG_VERSION="1.29.0.40-Omega"
PKG_SHA256="97bdcb0fb6d04243e3a7f0b476cfaf31b925c597b5ff27ee93bacc1f2b73e509"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.supafaust"
PKG_URL="https://github.com/kodi-game/game.libretro.supafaust/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-supafaust"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.supafaust: Beetle supafaust for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
