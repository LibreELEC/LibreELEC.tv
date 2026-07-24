# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mesen-s"
PKG_VERSION="0.4.0.24-Omega"
PKG_SHA256="33cf3d158d562f6de15f5c63c5abbe9a5fff5e2f9c89a088d5b064bbcc50ac1d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.mesen-s"
PKG_URL="https://github.com/kodi-game/game.libretro.mesen-s/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mesen-s"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mesen-s: mesen-s for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
