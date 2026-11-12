# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.genplus"
PKG_VERSION="1.7.4.86-Piers"
PKG_SHA256="f0815c387f10aeb17692027a81b7f69cfc273c2a13bc1e990cd8b3f731e0387f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.genplus"
PKG_URL="https://github.com/kodi-game/game.libretro.genplus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-genplus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.genplus: Genesis Plus GX emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
