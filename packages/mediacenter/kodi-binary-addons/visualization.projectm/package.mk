# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.projectm"
PKG_VERSION="22.3.3-Piers"
PKG_SHA256="24c303bd76bcb4f4b427e5d559c7d2e58b4e6ef4adc639ee4c78fb4b0f07dd84"
PKG_REV="1"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.projectm"
PKG_URL="https://github.com/xbmc/visualization.projectm/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libprojectM"
PKG_SECTION=""
PKG_SHORTDESC="visualization.projectm"
PKG_LONGDESC="visualization.projectm"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

pre_configure_target() {
  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||")
}
