# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dolphin"
PKG_VERSION="2609.0.0.41-Piers"
PKG_SHA256="15fede5861a0279a8a7c3955de2570fd70a78e04d79623f9e1168b3586d736d5"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.dolphin"
PKG_URL="https://github.com/kodi-game/game.libretro.dolphin/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-dolphin"
PKG_DEPENDS_UNPACK="libretro-dolphin"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dolphin: Dolphin for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
