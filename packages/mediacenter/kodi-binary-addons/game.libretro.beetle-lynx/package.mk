# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-lynx"
PKG_VERSION="1.24.0.59-Omega"
PKG_SHA256="5f4b7c6cc436b521447af7fe01dc1832240c9adf315cf7ba7518e7b3e804a048"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-lynx"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-lynx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-lynx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-lynx: Beetle lynx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
