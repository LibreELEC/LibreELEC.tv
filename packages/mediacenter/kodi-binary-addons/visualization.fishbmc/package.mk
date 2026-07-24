# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.fishbmc"
PKG_VERSION="22.1.0-Piers"
PKG_SHA256="bcb1e7e435746addae256bb5cb6304cf23834c74b105b2e9833a8c7dd1525054"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.fishbmc"
PKG_URL="https://github.com/xbmc/visualization.fishbmc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.fishbmc"
PKG_LONGDESC="visualization.fishbmc"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"
