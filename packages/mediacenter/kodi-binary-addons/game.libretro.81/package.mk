# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.81"
PKG_VERSION="1.0.0.37-Piers"
PKG_SHA256="8b6b43e7de3d8c72ebcc284469bb7bee4ffb318c67e8e4de3a429ba8fdeaee6e"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.81"
PKG_URL="https://github.com/kodi-game/game.libretro.81/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-81"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.81: 81 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
