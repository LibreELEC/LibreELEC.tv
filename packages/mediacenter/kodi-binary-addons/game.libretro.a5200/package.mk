# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.a5200"
PKG_VERSION="2.0.2.22-Omega"
PKG_SHA256="9ca56f703211f712d004a94ca2498cebc27f77e17e7b76f85692e086bdec81af"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.a5200"
PKG_URL="https://github.com/kodi-game/game.libretro.a5200/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-a5200"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.a5200: a5200 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
