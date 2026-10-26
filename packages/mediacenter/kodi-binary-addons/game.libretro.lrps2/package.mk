# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.lrps2"
PKG_VERSION="81678846fb135512ca4295188ad64fc931f7e971"
PKG_SHA256="36d20ca009bd42e6237f88f6620400e6a6d9c656039efd959d3d97ddd4a43be0"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.lrps2"
PKG_URL="https://github.com/kodi-game/game.libretro.lrps2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-lrps2"
PKG_DEPENDS_UNPACK="libretro-lrps2"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.lrps2: LRPS2 (PlayStation 2) for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
