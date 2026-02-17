# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-epgsearch"
PKG_VERSION="2.4.6"
PKG_SHA256="7bfb51ea6178d7b477e608fb78b18ee9db05676530d857758e22e4abe453a7c3"
PKG_LICENSE="GPL"
PKG_SITE="http://winni.vdr-developer.org/epgsearch/"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-epgsearch/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr pcre2"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="EPGSearch is a plugin for the Video-Disc-Recorder (VDR)."
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make \
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
