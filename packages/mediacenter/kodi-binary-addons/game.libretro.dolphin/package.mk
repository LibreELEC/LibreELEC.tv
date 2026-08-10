# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dolphin"
PKG_VERSION="83438.0.0.29-Omega"
PKG_SHA256="e0d037314fad67b948f00b092505faa96671b8298e33ccb8bcde8e5de2a6be3f"
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
