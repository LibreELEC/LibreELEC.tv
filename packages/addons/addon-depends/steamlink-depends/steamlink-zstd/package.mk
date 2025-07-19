# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory zstd)/package.mk

PKG_NAME="steamlink-zstd"
PKG_LONGDESC="zstd for steamlink-rpi"
PKG_URL=""
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS+=" -sysroot"

unpack() {
  mkdir -p ${PKG_BUILD}
  ${SCRIPTS}/get ${PKG_NAME:10}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:10}/${PKG_NAME:10}-${PKG_VERSION}.tar.zst -C ${PKG_BUILD}
}

configure_package() {
  PKG_MESON_SCRIPT="${PKG_BUILD}/build/meson/meson.build"
}

PKG_MESON_OPTS_TARGET="-Dlegacy_level=0 \
                       -Dbin_programs=false \
                       -Dlz4=disabled \
                       -Dlzma=disabled \
                       -Dzlib=disabled"
