# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.stella"
PKG_VERSION="8.0.0.89-Omega"
PKG_SHA256="88830cfa2fb6f44cb0d2e6b39988d8c31aab5d4ecf7cf20e6a181ef862f1e761"
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
