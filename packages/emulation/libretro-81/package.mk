# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-81"
PKG_VERSION="fa7094910d040baa5fd8b11dbf6a1a618330ecd9"
PKG_SHA256="fe8645529ce2140d29d2cad65dc2144bb3a41d858fd23345f85e412081d26aad"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/libretro/81-libretro"
PKG_URL="https://github.com/libretro/81-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of the EightyOne ZX81 Emulator to libretro"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

PKG_LIBNAME="81_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="81_LIB"

pre_make_target() {
  sed "s/HASH/${PKG_VERSION}/g" ${PKG_BUILD}/etc/version.c.templ >${PKG_BUILD}/src/version.c
  MAKEFLAGS+=" --assume-old=src/version.c"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
