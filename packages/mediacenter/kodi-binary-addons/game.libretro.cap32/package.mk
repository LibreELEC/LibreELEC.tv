# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.cap32"
PKG_VERSION="4.5.4.50-Omega"
PKG_SHA256="adebfa043a0f31867868796b15a2d2cc96fca1d084c43314bbb53fddf902eec0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.cap32"
PKG_URL="https://github.com/kodi-game/game.libretro.cap32/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-cap32"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.cap32: cap32 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
