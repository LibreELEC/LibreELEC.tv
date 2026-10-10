# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.lrps2"
PKG_VERSION="b7f9598aea4973d5640679db266b2f4f896b9a55"
PKG_SHA256="90a8fcc2ea03874c05f30f945d19ba3f6a81ab4cd8a7539de54fb468ccca8db8"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.lrps2"
PKG_URL="https://github.com/kodi-game/game.libretro.lrps2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-lrps2"
PKG_DEPENDS_UNPACK="libretro-lrps2"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.lrps2: LRPS2 (PlayStation 2) for Kodi"

# x86_64 only for now: the core's arm64 recompilers are new and untested here.
PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
