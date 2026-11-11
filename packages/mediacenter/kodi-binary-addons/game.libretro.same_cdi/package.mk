# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.same_cdi"
PKG_VERSION="0.287.0.20-Omega"
PKG_SHA256="03ca185f6760fae192c9d9886697eb46d3b4276f464d0318898af9e4c1f16e6b"
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
