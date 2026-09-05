# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.freechaf"
PKG_VERSION="1.0.0.35-Omega"
PKG_SHA256="cd02af78414f1f7a550f9363d95409dcccb63b1953eb735d1469c21a37d27fa0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.freechaf"
PKG_URL="https://github.com/kodi-game/game.libretro.freechaf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-freechaf"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.freechaf: FreeChaF for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
