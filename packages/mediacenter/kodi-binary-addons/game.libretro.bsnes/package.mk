# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bsnes"
PKG_VERSION="115.0.0.30-Piers"
PKG_SHA256="07e7a788d52f87ece2d04ef556d5d3220e8e03fc2e3eeeecc8d04e7cb84ccd26"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.bsnes"
PKG_URL="https://github.com/kodi-game/game.libretro.bsnes/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bsnes"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bsnes: bSNES for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
