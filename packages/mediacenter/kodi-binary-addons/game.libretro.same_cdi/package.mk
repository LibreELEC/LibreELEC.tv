# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.same_cdi"
PKG_VERSION="0.287.0.21-Piers"
PKG_SHA256="08a128ee9700047b3520c1035f2eb94dc7fd60c06eda5d56b9d3aa2ad836d690"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.same_cdi"
PKG_URL="https://github.com/kodi-game/game.libretro.same_cdi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-same_cdi"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.same_cdi: SAME_CDi for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
