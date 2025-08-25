# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory wayland)/package.mk

PKG_NAME="steamlink-wayland"
PKG_LONGDESC="wayland for steamlink-rpi"
PKG_URL=""
PKG_BUILD_FLAGS+=" -sysroot"

unpack() {
  mkdir -p ${PKG_BUILD}
  ${SCRIPTS}/get ${PKG_NAME:10}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.xz -C ${PKG_BUILD}
}

PKG_MESON_OPTS_TARGET="-Dlibraries=true \
                       -Dscanner=false \
                       -Dtests=false \
                       -Ddocumentation=false \
                       -Ddtd_validation=false"

# wayland build failure with DNDEBUG. see main package.
pre_configure_target() {
  export TARGET_CFLAGS=$(echo ${TARGET_CFLAGS} | sed -e "s|-DNDEBUG||g")
}
