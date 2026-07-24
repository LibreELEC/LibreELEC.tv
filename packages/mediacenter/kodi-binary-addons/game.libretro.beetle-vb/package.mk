# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-vb"
PKG_VERSION="1.31.0.43-Omega"
PKG_SHA256="19193bbf9be621f7923a3135c38d4405bf3f0c2a8fd32893b218a88a010ff2ef"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-vb"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-vb/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-vb"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-vb: Beetle vb for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
