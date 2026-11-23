# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pce"
PKG_VERSION="1.29.0.40-Piers"
PKG_SHA256="0523cfcd7cc7c5c7c70bdb1689a1bf0e18a6211bade1bae0c5504312d9e84254"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-pce"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-pce/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-pce"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-pce: Beetle PCE Fast for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
