# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-pcfx"
PKG_VERSION="0.9.36.46-Omega"
PKG_SHA256="8e4afe64996ff1f28adfb99c47f39e0247cb027ecbf3c6841382b82bb5956fb8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-pcfx"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-pcfx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-beetle-pcfx"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-pcfx: Beetle pcfx for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
