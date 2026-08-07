# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.yabasanshiro"
PKG_VERSION="3.4.2.12-Omega"
PKG_SHA256="5c8ab17ec3bf0590a42176447b1a111bc9e8a8843e4353e3ecdbe0a427c401f5"
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
