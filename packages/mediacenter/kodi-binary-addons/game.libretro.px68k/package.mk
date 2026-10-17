# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.px68k"
PKG_VERSION="0.15.0.36-Omega"
PKG_SHA256="37bbb2ed218b8117824d11ee95e00c15511a7379d36ac2105bc7cbd9657dfead"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.px68k"
PKG_URL="https://github.com/kodi-game/game.libretro.px68k/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-px68k"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.px68k: PX68k for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
