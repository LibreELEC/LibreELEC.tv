# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pcfx"
PKG_VERSION="0.9.36.50-Piers"
PKG_SHA256="aad8a840f2b29782fc85ff4855e3122c4d7b263e63b0a46b4c26c18bce632bdf"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-pcfx"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-pcfx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-pcfx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-pcfx: Beetle pcfx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
