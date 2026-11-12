# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.flycast"
PKG_VERSION="0.1.0.71-Piers"
PKG_SHA256="f1a5162c4acac0be17849a6723bf40ce4e86ea5d855664ce609915440775a400"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.flycast"
PKG_URL="https://github.com/kodi-game/game.libretro.flycast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-flycast"
PKG_DEPENDS_UNPACK="libretro-flycast"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.flycast: Flycast for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
