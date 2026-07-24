# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.stella"
PKG_VERSION="8.0.0.78-Omega"
PKG_SHA256="d3ebc3ecfa8889a878da233c3ecd1088d2cadad4a86e3c96a7071ecc0eb9923a"
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
