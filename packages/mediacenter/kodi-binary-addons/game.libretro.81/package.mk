# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.81"
PKG_VERSION="1.0.0.32-Omega"
PKG_SHA256="a7103984f5b70ce45100e1d78060923487d0d2b045193064a8815ada6216b0de"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.81"
PKG_URL="https://github.com/kodi-game/game.libretro.81/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-81"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.81: 81 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
