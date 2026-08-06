# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.neocd"
PKG_VERSION="20.22.0.27-Omega"
PKG_SHA256="58a79c8bf0a963954333039198b89bd45b52089970eb46b8f9d1f24fb556978e"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL-3.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.neocd"
PKG_URL="https://github.com/kodi-game/game.libretro.neocd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-neocd"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.neocd: NeoCD for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
