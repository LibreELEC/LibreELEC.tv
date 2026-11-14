# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.goom"
PKG_VERSION="22.1.2-Piers"
PKG_SHA256="3bb77b47d26aaf1e6cca451bbb9c22f162101f3a43b014a1bfa3583329e08f44"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.goom"
PKG_URL="https://github.com/xbmc/visualization.goom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.goom"
PKG_LONGDESC="visualization.goom"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"
