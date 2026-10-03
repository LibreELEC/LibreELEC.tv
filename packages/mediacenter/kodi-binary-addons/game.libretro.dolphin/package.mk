# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dolphin"
PKG_VERSION="2606.0.0.34-Omega"
PKG_SHA256="99d97c61666aa2e990628d26cf3f51c1130b577974d1b821dbaa3b6c16436c9e"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.dolphin"
PKG_URL="https://github.com/kodi-game/game.libretro.dolphin/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-dolphin"
PKG_DEPENDS_UNPACK="libretro-dolphin"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dolphin: Dolphin for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
