# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory libjpeg-turbo)/package.mk

PKG_NAME="steamlink-libjpeg-turbo"
PKG_LONGDESC="libjpeg-turbo for steamlink"
PKG_URL=""
PKG_DEPENDS_UNPACK+=" libjpeg-turbo"
PKG_BUILD_FLAGS+=" -sysroot"

PKG_CMAKE_OPTS_TARGET+=" -DENABLE_STATIC=OFF \
                         -DENABLE_SHARED=ON \
                         -DWITH_JPEG8=OFF"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}
