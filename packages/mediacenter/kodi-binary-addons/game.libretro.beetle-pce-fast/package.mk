# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pce-fast"
PKG_VERSION="1.31.0.70-Piers"
PKG_SHA256="53dc6290429332f9bf9fd6764decadd73a04e9439d94d40a23116201db27d704"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-pce-fast"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-pce-fast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-pce-fast"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-pce-fast: Beetle PCE Fast for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
