# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vice_x64"
PKG_VERSION="3.10.0.72-Omega"
PKG_SHA256="4d428db5c4a1a6cb80373e6b1ffa063630049f0ef778a05ee14a0744fb830f55"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.vice_x64"
PKG_URL="https://github.com/kodi-game/game.libretro.vice_x64/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vice_x64"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vice_x64: vice (x64) emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
