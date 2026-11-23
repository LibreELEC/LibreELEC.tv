# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-psx"
PKG_VERSION="0.9.44.96-Piers"
PKG_SHA256="39d78bbc2a230d7b46527dfe32ff2e4e5e65f5b7ff213d28c2a9792c2b2ec2e4"
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
