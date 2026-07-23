# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gw"
PKG_VERSION="1.6.3.36-Omega"
PKG_SHA256="ed859279139f0f69601e049e4d49cf9be84e97c36957a52861546741f70c0794"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/kodi-game/game.libretro.gw"
PKG_URL="https://github.com/kodi-game/game.libretro.gw/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-gw"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.gw: gw for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
