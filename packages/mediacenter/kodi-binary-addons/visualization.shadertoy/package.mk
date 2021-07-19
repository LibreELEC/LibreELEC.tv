# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.shadertoy"
PKG_VERSION="19.0.0-Matrix"
PKG_SHA256="6c106c0d8e53f9b0794291a1c53e9a00370ff79be73919d556048dce0bb9785c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/visualization.shadertoy"
PKG_URL="https://github.com/xbmc/visualization.shadertoy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.shadertoy"
PKG_LONGDESC="visualization.shadertoy"

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
