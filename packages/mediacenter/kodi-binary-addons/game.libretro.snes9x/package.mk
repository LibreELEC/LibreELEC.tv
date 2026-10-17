# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.snes9x"
PKG_VERSION="1.63.0.63-Omega"
PKG_SHA256="c84d58a931890e3e037ef4550a5a85583d9201a922931a212c62cb02651c8ff3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.snes9x"
PKG_URL="https://github.com/kodi-game/game.libretro.snes9x/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-snes9x"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.snes9x: snes9x for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
