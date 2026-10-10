# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.crocods"
PKG_VERSION="0.0.1.35-Omega"
PKG_SHA256="e27ded0dadd772e51ae9a066c420c6fd6058858d816ca51c816b095682285b96"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/kodi-game/game.libretro.crocods"
PKG_URL="https://github.com/kodi-game/game.libretro.crocods/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-crocods"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.crocods: CrocoDS for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
