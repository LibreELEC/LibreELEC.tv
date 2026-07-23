# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.picodrive"
PKG_VERSION="2.05.0.57-Omega"
PKG_SHA256="83ba658e71a138e84db10a01ad49dae585df63b7d8445d271c0051cbac81fb85"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.picodrive"
PKG_URL="https://github.com/kodi-game/game.libretro.picodrive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-picodrive"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.picodrive: picodrive for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
