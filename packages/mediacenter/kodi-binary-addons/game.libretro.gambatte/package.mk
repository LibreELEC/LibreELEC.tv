# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gambatte"
PKG_VERSION="0.5.0.73-Piers"
PKG_SHA256="66f8a52836c83175d400d1db0b93e02008f6b605696d8a4ed3b162c1a541ea7c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.gambatte"
PKG_URL="https://github.com/kodi-game/game.libretro.gambatte/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-gambatte"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.gambatte: Gambatte emulator for Kodi"
PKG_IS_ADDON="yes"

PKG_ADDON_TYPE="kodi.gameclient"
