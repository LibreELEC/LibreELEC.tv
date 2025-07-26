# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-satip"
PKG_VERSION="20250621"
PKG_SHA256="25e91ca2cd22fdb9f445395579f39054fddab31c06982a7c5a96fa851c56067f"
PKG_LICENSE="GPL"
PKG_SITE="https://vdr-projects.github.io/"
PKG_URL="https://github.com/wirbel-at-vdr-portal/vdr-plugin-satip/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr curl librepfunc tinyxml"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="This is an SAT>IP plugin for the Video Disk Recorder (VDR)."
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include:$(get_install_dir librepfunc)/usr/include
  export LDFLAGS+=" -L$(get_install_dir librepfunc)/usr/lib"

  make \
    SATIP_USE_TINYXML=1 \
    LIBDIR="." \
    LOCDIR="./locale" \
    all install-i18n
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=$(sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' ${VDR_DIR}/config.h)
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination ${PKG_BUILD}/${LIB_NAME}.so ${PKG_BUILD}/${LIB_NAME}.so.${VDR_APIVERSION}
}
