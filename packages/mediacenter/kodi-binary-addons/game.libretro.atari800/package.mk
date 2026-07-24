# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.atari800"
PKG_VERSION="3.1.0.43-Omega"
PKG_SHA256="e6c4800cae40d08f10cfd1ad96636f49bc73218816bf388b27373bc232b686b6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.atari800"
PKG_URL="https://github.com/kodi-game/game.libretro.atari800/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-atari800"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.atari800: atari800 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
