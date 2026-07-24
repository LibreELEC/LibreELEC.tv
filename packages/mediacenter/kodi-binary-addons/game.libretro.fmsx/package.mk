# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.fmsx"
PKG_VERSION="6.0.0.47-Omega"
PKG_SHA256="157f275a0199ef52681ed5310e990769e8f7cbc6add08878324a3bc30d58cb61"
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
