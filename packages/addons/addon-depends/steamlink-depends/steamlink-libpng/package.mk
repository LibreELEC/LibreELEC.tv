# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory libpng)/package.mk

PKG_NAME="steamlink-libpng"
PKG_LONGDESC="libpng for steamlink-rpi"
PKG_URL=""
PKG_DEPENDS_TARGET+=" libpng"
PKG_BUILD_FLAGS+=" -sysroot"

PKG_CONFIGURE_OPTS_TARGET+=" --disable-static \
                             --enable-shared"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.xz -C ${PKG_BUILD}
}

post_makeinstall_target() {
  :
}
