# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.pictureit"
PKG_VERSION="22.1.1-Piers"
PKG_SHA256="eb7f9fefa8b8363b3000a0905e5b1efa7b6ed4a5180d1d8ba37037b605084883"
PKG_REV="2"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/xbmc/visualization.pictureit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.pictureit"
PKG_LONGDESC="visualization.pictureit"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"
