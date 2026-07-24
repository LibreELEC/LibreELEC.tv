# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.nx"
PKG_VERSION="1.0.0.45-Omega"
PKG_SHA256="caa622edba8f404da04ad33d4eed3c46b782134fe65035f426d747a75cc28483"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.nx"
PKG_URL="https://github.com/kodi-game/game.libretro.nx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-nx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.nx: nx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
