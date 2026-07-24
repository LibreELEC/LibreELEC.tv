# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dosbox-pure"
PKG_VERSION="1.0.0.42-Omega"
PKG_SHA256="2ddf73ba663b2d94dc7417c93483d1985dbb1f79290502657ab1a572d79965c5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.dosbox-pure"
PKG_URL="https://github.com/kodi-game/game.libretro.dosbox-pure/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-dosbox-pure"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dosbox-pure: DOSBox-Pure for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
