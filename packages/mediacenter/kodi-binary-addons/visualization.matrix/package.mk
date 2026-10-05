# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.matrix"
PKG_VERSION="22.1.1-Piers"
PKG_SHA256="a0060d82a8a9e9cdf2fb30451116271d5ab1dd9196c27cda1f6ae7eb1f787b02"
PKG_REV="2"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.matrix"
PKG_URL="https://github.com/xbmc/visualization.matrix/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="Matrix digital rain music visualization"
PKG_LONGDESC="Matrix digital rain music visualization"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ ! "${OPENGL}" = "no" ]; then
  # for OpenGL (GLX) support
  PKG_DEPENDS_TARGET+=" ${OPENGL} glew"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  # for OpenGL-ES support
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi
