# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.picodrive"
PKG_VERSION="2.05.0.64-Piers"
PKG_SHA256="395c7f6e9abda3a856759726a8a2a61a385d58b4cca6bfd9c1e55a7954b06480"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/kodi-game/game.libretro.picodrive"
PKG_URL="https://github.com/kodi-game/game.libretro.picodrive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-picodrive"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.picodrive: picodrive for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
