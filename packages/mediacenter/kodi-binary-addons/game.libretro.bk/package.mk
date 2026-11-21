# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bk"
PKG_VERSION="1.0.0.39-Piers"
PKG_SHA256="4005e3907b403e658239c2bb5331c934b8e6ffe42340fbce1106701443a735d3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.bk"
PKG_URL="https://github.com/kodi-game/game.libretro.bk/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bk"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bk: bk for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
