# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-lynx"
PKG_VERSION="1.24.0.63-Piers"
PKG_SHA256="ea6b4a66e47f83390c7557d4cfbda09423a275f61e6a1ef56d4efb94bfe3f711"
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
