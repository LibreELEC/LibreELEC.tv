# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.pcsx-rearmed"
PKG_VERSION="26.0.0.84-Piers"
PKG_SHA256="9184caecbf7c723ff1719293a88a16027e6f5c8a6ebd2651df05bbe15e7d7b02"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.pcsx-rearmed"
PKG_URL="https://github.com/kodi-game/game.libretro.pcsx-rearmed/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-pcsx-rearmed"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
