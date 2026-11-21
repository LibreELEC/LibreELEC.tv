# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.cap32"
PKG_VERSION="4.5.4.54-Piers"
PKG_SHA256="75a03a7d9b1cef88a3933685382373bc43bb33716b773dfb15611fde8e2d8f27"
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
