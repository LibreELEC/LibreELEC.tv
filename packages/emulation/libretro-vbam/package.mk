# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vbam"
PKG_VERSION="c6a055ed2800066ebf854aa547194c569a27b1f7"
PKG_SHA256="04f99dba914b2be04becc56f39cbeaf35291d7d49e72c7ec23a0b867cdcb53b6"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/visualboyadvance-m/visualboyadvance-m"
PKG_URL="https://github.com/visualboyadvance-m/visualboyadvance-m/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="VBA-M with libretro integration"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="vbam_libretro.so"
PKG_LIBPATH="../src/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="VBAM_LIB"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro/"

pre_make_target() {
  MAKEFLAGS+=" CURRENT_COMMIT=${PKG_VERSION:0:7}"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
