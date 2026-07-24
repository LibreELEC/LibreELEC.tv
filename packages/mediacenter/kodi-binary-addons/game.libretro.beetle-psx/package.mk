# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-psx"
PKG_VERSION="0.9.44.82-Omega"
PKG_SHA256="9a8c9350bb7b619730d19538ecc89a382191c9cdf9997f882fa5e169d1cced1a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-psx"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-psx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-psx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-psx: Beetle PSX for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
