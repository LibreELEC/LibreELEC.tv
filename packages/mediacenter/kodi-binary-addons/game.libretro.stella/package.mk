# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.stella"
PKG_VERSION="8.0.0.93-Piers"
PKG_SHA256="8d72f3113ea6aa9f4e729659c36b5d0b684d0c5b944441414f9aa87db6299e71"
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
