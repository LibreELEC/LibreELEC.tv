# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.yabasanshiro"
PKG_VERSION="3.4.2.15-Omega"
PKG_SHA256="b1ff8b4d99a0204219f2f38c82573ad0ab43be80ccdcc9380627a0192b7a9652"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.yabasanshiro"
PKG_URL="https://github.com/kodi-game/game.libretro.yabasanshiro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-yabasanshiro"
PKG_DEPENDS_UNPACK="libretro-yabasanshiro"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.yabasanshiro: Yaba Sanshiro for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
