# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.prboom"
PKG_VERSION="2.5.0.56-Omega"
PKG_SHA256="2682e58832f1ddab3d558d0635b78d78f618109b65ca6174275d9c56cab5c82d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.prboom"
PKG_URL="https://github.com/kodi-game/game.libretro.prboom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-prboom"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.prboom: prboom for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
