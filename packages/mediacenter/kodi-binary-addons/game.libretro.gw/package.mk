# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gw"
PKG_VERSION="1.6.3.40-Piers"
PKG_SHA256="c0981988a228e908a8a5232e07a9adc8d03662488f2eebdc326938860be3c316"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/kodi-game/game.libretro.gw"
PKG_URL="https://github.com/kodi-game/game.libretro.gw/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-gw"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.gw: gw for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
