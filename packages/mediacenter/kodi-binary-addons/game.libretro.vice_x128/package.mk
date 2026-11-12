# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vice_x128"
PKG_VERSION="3.10.0.42-Piers"
PKG_SHA256="2a369f0c5c306402d33840f36be7de6231e46c23f2160d333d4ec78f8cbc3157"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.vice_x128"
PKG_URL="https://github.com/kodi-game/game.libretro.vice_x128/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vice_x128"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vice_x128: vice (x128) emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
