# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.blastem"
PKG_VERSION="0.6.3.36-Omega"
PKG_SHA256="cce5185efaadf6c32ae0255db4c37d56dad4ad5d8c6dc048aa9d98174e2c9d8b"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.blastem"
PKG_URL="https://github.com/kodi-game/game.libretro.blastem/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-blastem"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.blastem: blastem for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
