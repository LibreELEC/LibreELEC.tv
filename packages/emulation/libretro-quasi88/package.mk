# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-quasi88"
PKG_VERSION="ac1e8743cf45d985d8f19191779a9407fc1b41de"
PKG_SHA256="9b51417a0f84497997eba8c97d563c4d0f1dc9c8394f25f71641380626183f14"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/libretro/quasi88-libretro"
PKG_URL="https://github.com/libretro/quasi88-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of QUASI88 to the libretro API, a NEC PC-8801 emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="quasi88_libretro.so"
PKG_LIBPATH="quasi88_libretro.so"
PKG_LIBVAR="QUASI88_LIB"

pre_make_target() {
  # the core does not build as C23, the default since GCC 15
  CFLAGS+=" -std=gnu17"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
