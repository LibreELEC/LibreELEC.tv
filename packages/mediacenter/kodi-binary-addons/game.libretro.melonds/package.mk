# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.melonds"
PKG_VERSION="0.9.3.48-Omega"
PKG_SHA256="9ebbd88a842371171ed732546ef47216600a2c37a004c0adbc2e577c331d8d5b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.melonds"
PKG_URL="https://github.com/kodi-game/game.libretro.melonds/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-melonds"
PKG_DEPENDS_UNPACK="libretro-melonds"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.melonds: melonDS for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
