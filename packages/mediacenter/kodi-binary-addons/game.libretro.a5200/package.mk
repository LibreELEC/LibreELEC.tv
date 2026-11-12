# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.a5200"
PKG_VERSION="2.0.2.28-Piers"
PKG_SHA256="a567453a88b48109a378ab62acb48b36bb9d00f119c6250e0c9b6fc1a215e637"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.a5200"
PKG_URL="https://github.com/kodi-game/game.libretro.a5200/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-a5200"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.a5200: a5200 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
