# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.dosbox-pure"
PKG_VERSION="1.0.0.47-Piers"
PKG_SHA256="011d62b45f6619ad43bc263536bfb6cc47d673716543715e24dba72b89af5e65"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.dosbox-pure"
PKG_URL="https://github.com/kodi-game/game.libretro.dosbox-pure/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-dosbox-pure"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dosbox-pure: DOSBox-Pure for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
