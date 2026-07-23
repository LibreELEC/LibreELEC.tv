# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-gba"
PKG_VERSION="0.9.36.36-Omega"
PKG_SHA256="3bf8cbd19a6ff07d09bf17cee52bb48afd5f282580e912bb22760ec8c358fac8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-gba"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-gba/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-gba"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-gba: Beetle GBA for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
