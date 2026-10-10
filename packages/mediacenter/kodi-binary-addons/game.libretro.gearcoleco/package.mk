# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gearcoleco"
PKG_VERSION="1.6.10.41-Omega"
PKG_SHA256="029cc010a47629cac6089af79b5d3613de4fc491e417ace9a4c8ef80a76869a0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.gearcoleco"
PKG_URL="https://github.com/kodi-game/game.libretro.gearcoleco/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-gearcoleco"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.gearcoleco: Gearcoleco for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
