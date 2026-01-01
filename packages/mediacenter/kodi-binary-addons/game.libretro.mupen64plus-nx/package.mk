# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mupen64plus-nx"
PKG_VERSION="914c98d9db4c5ec9d2fd51ab3f2ec4ec9d17ae3f"
PKG_SHA256="a9713229540e69ef9c0e6cc310380ec511077383ffecc40a78ae97c06ef7d20d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/kodi-game/game.libretro.mupen64plus-nx"
PKG_URL="https://github.com/kodi-game/game.libretro.mupen64plus-nx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-mupen64plus-nx"
PKG_DEPENDS_UNPACK="libretro-mupen64plus-nx"
PKG_SECTION=""
PKG_LONGDESC="Mupen64Plus-Next is N64 emulation library for the libretro API, based on Mupen64Plus"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
