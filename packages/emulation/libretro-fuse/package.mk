# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fuse"
PKG_VERSION="bce196fb774835fe65b3e5b821887a4ccf657167"
PKG_SHA256="43c9b548298142583c1030084aad1586ba521f0d2f84c3f56f7094d0a0f389b9"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="https://github.com/libretro/fuse-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bzip2"
PKG_LONGDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_TOOLCHAIN="make"

PKG_LIBNAME="fuse_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FUSE_LIB"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  sed "s/HASH/${PKG_VERSION}/g" ${PKG_BUILD}/etc/version.c.templ >${PKG_BUILD}/src/version.c
  MAKEFLAGS+=" --assume-old=src/version.c"
  CFLAGS+=" -DHAVE_LIBBZ2"
  CXXFLAGS+=" -DHAVE_LIBBZ2"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
