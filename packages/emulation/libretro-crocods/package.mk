# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-crocods"
PKG_VERSION="a9c63b29443715ae2add392010fca4eae7f93e67"
PKG_SHA256="e2d2ce649fa390e277ea7db15d376027b1f69b42c4767c5551e972015c6d2768"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-crocods"
PKG_URL="https://github.com/libretro/libretro-crocods/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of CrocoDS to the libretro API, an Amstrad CPC emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="crocods_libretro.so"
PKG_LIBPATH="crocods_libretro.so"
PKG_LIBVAR="CROCODS_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
