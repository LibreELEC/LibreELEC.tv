# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.picodrive"
PKG_VERSION="2.05.0.65-Piers"
PKG_SHA256="7cc24e8473c5dc59c40719445aec13d7af7c99d4d68034a814618b1c1a2e7b6f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.picodrive"
PKG_URL="https://github.com/kodi-game/game.libretro.picodrive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-picodrive"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.picodrive: picodrive for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
