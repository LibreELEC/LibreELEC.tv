# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mgba"
PKG_VERSION="0.11.0.57-Omega"
PKG_SHA256="e30bda02270fbef074a61cc78a9e2a124bfa70aa168c1e2d972e3f6182cf7864"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MPL-2.0"
PKG_SITE="https://github.com/kodi-game/game.libretro.mgba"
PKG_URL="https://github.com/kodi-game/game.libretro.mgba/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mgba"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mgba: mGBA emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
