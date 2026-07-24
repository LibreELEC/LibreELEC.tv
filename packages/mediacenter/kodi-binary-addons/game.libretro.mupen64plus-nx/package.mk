# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mupen64plus-nx"
PKG_VERSION="2.8.0.57-Omega"
PKG_SHA256="f818406e45feb44cbb961356c6d5cbc746ab9249db5df2894a0fa6abb7e2c035"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.mupen64plus-nx"
PKG_URL="https://github.com/kodi-game/game.libretro.mupen64plus-nx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mupen64plus-nx"
PKG_DEPENDS_UNPACK="libretro-mupen64plus-nx"
PKG_SECTION=""
PKG_LONGDESC="Mupen64Plus-Next is N64 emulation library for the libretro API, based on Mupen64Plus"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
