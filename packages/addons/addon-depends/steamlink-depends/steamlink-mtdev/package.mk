# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory mtdev)/package.mk

PKG_NAME="steamlink-mtdev"
PKG_LONGDESC="mtdev for steamlink-rpi"
PKG_URL=""
PKG_BUILD_FLAGS+=" -sysroot"

unpack() {
  mkdir -p ${PKG_BUILD}
  ${SCRIPTS}/get ${PKG_NAME:10}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.bz2 -C ${PKG_BUILD}
}

PKG_CONFIGURE_OPTS_TARGET="--disable-static --enable-shared"
