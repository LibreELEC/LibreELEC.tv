# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.stella"
PKG_VERSION="8.0.0.91-Piers"
PKG_SHA256="4dbb5d14cb33473f1e0dac14b7e188c39aaa64545e26dccbd70d6cedbe4140b3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.stella"
PKG_URL="https://github.com/kodi-game/game.libretro.stella/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-stella"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.stella: Stella emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
