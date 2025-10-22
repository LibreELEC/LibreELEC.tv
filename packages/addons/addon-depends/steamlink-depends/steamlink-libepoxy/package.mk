# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory libepoxy)/package.mk

PKG_NAME="steamlink-libepoxy"
PKG_LONGDESC="libepoxy for steamlink-rpi"
PKG_URL=""
PKG_BUILD_FLAGS+=" -sysroot"

unpack() {
  mkdir -p ${PKG_BUILD}
  ${SCRIPTS}/get ${PKG_NAME:10}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}
