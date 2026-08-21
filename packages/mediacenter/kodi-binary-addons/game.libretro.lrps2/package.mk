# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.lrps2"
PKG_VERSION="3265026f79af8795d54261447611707907d5f8e5"
PKG_SHA256="7a29e970ceb9764cc74347810b80ba16098eae8e9ce8cf4790f034c13b62095c"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.lrps2"
PKG_URL="https://github.com/kodi-game/game.libretro.lrps2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-lrps2"
PKG_DEPENDS_UNPACK="libretro-lrps2"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.lrps2: LRPS2 (PlayStation 2) for Kodi"

# x86_64 only: PCSX2's recompilers and GS renderer are x86 assembly, and the
# core will not build for ARM at all.
PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

# The BIOS the core looks for lives outside the add-on, at
#   userdata/addon_data/game.libretro.lrps2/resources/system/pcsx2/bios/
# which is where game.libretro points RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY,
# plus the pcsx2/bios subdirectory the core appends itself. Without a BIOS
# there, retro_init returns before registering any options and the load fails.
