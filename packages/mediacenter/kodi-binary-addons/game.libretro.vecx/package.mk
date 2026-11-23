# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.vecx"
PKG_VERSION="1.2.0.55-Piers"
PKG_SHA256="eb33ae59ad889f93b8a4a8554aa5460d543a4d9a5bb72aa2274b54f28f6522ea"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.vecx"
PKG_URL="https://github.com/kodi-game/game.libretro.vecx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-vecx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.vecx: vecx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
