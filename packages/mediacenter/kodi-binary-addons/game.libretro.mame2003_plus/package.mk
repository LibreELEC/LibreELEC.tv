# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mame2003_plus"
PKG_VERSION="0.0.1.98-Omega"
PKG_SHA256="af97344208060fc2a59fb22612aa5ad6476e9f0ca18c63f30b248019dd07bc6d"
PKG_REV="1"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.mame2003_plus"
PKG_URL="https://github.com/kodi-game/game.libretro.mame2003_plus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mame2003_plus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mame2003_plus: MAME 2003 Plus emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
