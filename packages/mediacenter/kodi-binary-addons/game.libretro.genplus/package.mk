# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.genplus"
PKG_VERSION="1.7.4.87-Piers"
PKG_SHA256="3fc7d7ea391d2729fcf472102eae32a2c63315fb0dafb85f76cb19d262334f9a"
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
