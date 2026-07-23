# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bsnes-mercury-performance"
PKG_VERSION="0.94.0.39-Omega"
PKG_SHA256="f29919563dfbe1953cf2899d38563e4af64a3552035b5171685f265cdec93ea8"
PKG_REV="1"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.bsnes-mercury-performance"
PKG_URL="https://github.com/kodi-game/game.libretro.bsnes-mercury-performance/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bsnes-mercury-performance"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bsnes-mercury-performance: bSNES Mercury for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
