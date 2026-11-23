# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mgba"
PKG_VERSION="0.11.0.62-Piers"
PKG_SHA256="49185419aaec74064ecc174481b255a8c7e638cce047ce0cfea0e8ab1bea6394"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MPL-2.0"
PKG_SITE="https://github.com/kodi-game/game.libretro.mgba"
PKG_URL="https://github.com/kodi-game/game.libretro.mgba/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mgba"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mgba: mGBA emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
