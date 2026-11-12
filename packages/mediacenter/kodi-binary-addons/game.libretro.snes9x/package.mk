# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.snes9x"
PKG_VERSION="1.63.0.64-Piers"
PKG_SHA256="a94b91c0fffd1071aae0f6ff4e3bf71e68556d7297def3325c1067af204784ef"
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
