# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.yabause"
PKG_VERSION="0.9.15.81-Piers"
PKG_SHA256="d148ee5f1dd2605fde9294350f10e1899ea719ec75f58c54930704a427c9469b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.yabause"
PKG_URL="https://github.com/kodi-game/game.libretro.yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-yabause"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.yabause: Yabause emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
