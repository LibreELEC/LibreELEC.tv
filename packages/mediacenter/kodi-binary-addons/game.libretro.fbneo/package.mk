# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.fbneo"
PKG_VERSION="1.0.0.96-Omega"
PKG_SHA256="6264c1cd50eabb3ab7b6a7e29de0c70b7238a4f606dc1855020c7e624277e485"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/kodi-game/game.libretro.fbneo"
PKG_URL="https://github.com/kodi-game/game.libretro.fbneo/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-fbneo"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.fbneo: FinalBurn Neo GameClient for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
