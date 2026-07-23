# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pce"
PKG_VERSION="1.29.0.35-Omega"
PKG_SHA256="855f8a7610688eb6dda3f4e732a85129089ca69a1031a9e72c07ac98951d191b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-pce"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-pce/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-pce"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-pce: Beetle PCE Fast for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
