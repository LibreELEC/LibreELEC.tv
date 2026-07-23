# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.opera"
PKG_VERSION="1.0.0.52-Omega"
PKG_SHA256="c7561ae21353ea2297083b0eb0fcd626184fc560fe220e1f6513d1a2965c4dfd"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-FreeDO"
PKG_SITE="https://github.com/kodi-game/game.libretro.opera"
PKG_URL="https://github.com/kodi-game/game.libretro.opera/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-opera"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.opera: Port of 4DO/libfreedo for Kodi."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
