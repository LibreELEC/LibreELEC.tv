# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mesen"
PKG_VERSION="0.9.9.42-Omega"
PKG_SHA256="cc9b6b404298ae5e965cdacad511523a8ac0bfd3b13f0d3887527c39f1a25a8f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.mesen"
PKG_URL="https://github.com/kodi-game/game.libretro.mesen/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mesen"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mesen: mesen for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
