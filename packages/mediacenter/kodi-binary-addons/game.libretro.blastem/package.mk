# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.blastem"
PKG_VERSION="1.0.1.43-Piers"
PKG_SHA256="7671ccb86b8aaab9f274b58a4f7fab063b25b4ff13b52e2bb8c73187638b6e00"
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
