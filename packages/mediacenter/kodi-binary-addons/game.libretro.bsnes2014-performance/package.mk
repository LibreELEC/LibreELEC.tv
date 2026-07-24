# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bsnes2014-performance"
PKG_VERSION="0.94.0.26-Omega"
PKG_SHA256="0e29dcc47305bdd623866ee83c799249f75ad9b89374612800a9db487ff9a620"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.bsnes2014-performance"
PKG_URL="https://github.com/kodi-game/game.libretro.bsnes2014-performance/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bsnes2014-performance"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bsnes2014-performance: bSNES 2014 for Kodi (performance profile)"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
