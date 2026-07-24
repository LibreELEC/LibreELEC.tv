# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-supergrafx"
PKG_VERSION="1.29.0.49-Omega"
PKG_SHA256="50db148f78c8b7d3d26fa062e519e91a90cda19a50d9e03602c68c1a5ef006bf"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-supergrafx"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-supergrafx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-supergrafx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-supergrafx: Beetle supergrafx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
