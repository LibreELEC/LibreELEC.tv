# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.cap32"
PKG_VERSION="4.5.4.55-Piers"
PKG_SHA256="3c23b4aef3ae440288e39e56ad7606d756975611da9b25270683893817d889ca"
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
