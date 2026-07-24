# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.pictureit"
PKG_VERSION="22.1.0-Piers"
PKG_SHA256="8ec0bb106d76927676072e222d916e2dbcfc91004a32cea3477aff57bccf637b"
PKG_REV="1"
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
