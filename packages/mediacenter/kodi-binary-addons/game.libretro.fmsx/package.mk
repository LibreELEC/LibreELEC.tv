# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.fmsx"
PKG_VERSION="6.0.0.52-Piers"
PKG_SHA256="9e84eb0e3e8587acd4547390eec55bd67054d67610581d621d5c90f5430e8175"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.fmsx"
PKG_URL="https://github.com/kodi-game/game.libretro.fmsx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-fmsx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.fmsx: fmsx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
