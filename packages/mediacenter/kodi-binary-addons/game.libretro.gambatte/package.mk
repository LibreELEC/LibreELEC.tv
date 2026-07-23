# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gambatte"
PKG_VERSION="0.5.0.63-Omega"
PKG_SHA256="4f352b52446a30c0662c24d53c183843624e6e574f023178438d8bbc633840a9"
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
