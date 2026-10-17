# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.same_cdi"
PKG_VERSION="0.287.0.19-Omega"
PKG_SHA256="cde9ad20bcba2297ae20cb67f7c2edefd639fb1cb43168eeb4e8ecba72959445"
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
