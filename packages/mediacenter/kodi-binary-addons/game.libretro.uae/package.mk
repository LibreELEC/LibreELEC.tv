# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.uae"
PKG_VERSION="5.3.1.91-Omega"
PKG_SHA256="78a9175ff717e9703f517573017ccee928ea27db7b2d80f39ab9131b355be8d9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.uae"
PKG_URL="https://github.com/kodi-game/game.libretro.uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-uae"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.uae: uae emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
