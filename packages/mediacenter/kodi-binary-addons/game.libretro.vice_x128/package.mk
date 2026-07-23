# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vice_x128"
PKG_VERSION="3.10.0.34-Omega"
PKG_SHA256="45ae30f59a4f790203ef30b4a797f46f450e22dae83c722e8a3586d10fdcb7a2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.vice_x128"
PKG_URL="https://github.com/kodi-game/game.libretro.vice_x128/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vice_x128"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vice_x128: vice (x128) emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
