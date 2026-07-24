# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.bluemsx"
PKG_VERSION="0.0.1.49-Omega"
PKG_SHA256="34918e883503af364847c729a79dd3d23d5ec160f78a9bb3373b9318808e3a6a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.bluemsx"
PKG_URL="https://github.com/kodi-game/game.libretro.bluemsx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-bluemsx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.bluemsx: BlueMSX for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
