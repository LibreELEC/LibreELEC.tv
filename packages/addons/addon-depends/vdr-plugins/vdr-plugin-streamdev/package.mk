# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-streamdev"
PKG_VERSION="0.6.4"
PKG_SHA256="1698afccb5fde1ea4e40794ae187fa42ce7fc38af48c12ecd3fa1d3154c6c794"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-streamdev"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-streamdev/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr openssl"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="This PlugIn is a VDR implementation of Video Transfer and a basic HTTP Streaming Protocol."
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make \
    LIBDIR="." \
    LOCDIR="./locale" \
    all
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=$(sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' ${VDR_DIR}/config.h)
  LIB_NAME=lib${PKG_NAME/-plugin/}
  cp --remove-destination ${PKG_BUILD}/server/${LIB_NAME}-server.so ${PKG_BUILD}/server/${LIB_NAME}-server.so.${VDR_APIVERSION}
  cp --remove-destination ${PKG_BUILD}/client/${LIB_NAME}-client.so ${PKG_BUILD}/client/${LIB_NAME}-client.so.${VDR_APIVERSION}
}
