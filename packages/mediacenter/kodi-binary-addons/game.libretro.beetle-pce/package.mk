# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pce"
PKG_VERSION="1.29.0.39-Piers"
PKG_SHA256="e97c92b69781ccc43c489b17eb4bf94ea4b75efd8f79dbaa7702164131eb48d4"
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
