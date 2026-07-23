# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.hatari"
PKG_VERSION="1.8.0.43-Omega"
PKG_SHA256="a749441e199b3eb88e8ac15ae7d7bbe8112bda7165eb1bd72759b0cc8e782e03"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.hatari"
PKG_URL="https://github.com/kodi-game/game.libretro.hatari/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-hatari"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.hatari: hatari for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
