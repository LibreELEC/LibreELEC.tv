# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vice_xvic"
PKG_VERSION="3.10.0.34-Omega"
PKG_SHA256="240fbe0d59ce8c27679608ef84cefd35b72f5a3692320e8f5f9c25f53c899b54"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.vice_xvic"
PKG_URL="https://github.com/kodi-game/game.libretro.vice_xvic/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vice_xvic"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vice_xvic: vice (xvic) emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
