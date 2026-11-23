# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dosbox"
PKG_VERSION="4494.0.0.37-Piers"
PKG_SHA256="1f186a904d4f68b2b18bddb949c97b96f326f0f8e7316e819618795e2e101779"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.dosbox"
PKG_URL="https://github.com/kodi-game/game.libretro.dosbox/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-dosbox"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dosbox: DOSBox for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
