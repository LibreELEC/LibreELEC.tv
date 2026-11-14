# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-same_cdi"
PKG_VERSION="ff9bb99a50d518aef6d2add1c49b7c44447e3e78"
PKG_SHA256="a716b7de6d1f8e70d3b053cece9c2f11388f674c0071036b5cb3a9296bb473ce"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/same_cdi"
PKG_URL="https://github.com/libretro/same_cdi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SAME_CDi, a Philips CD-i emulator based on MAME, for the libretro API."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

PKG_LIBNAME="same_cdi_libretro.so"
PKG_LIBPATH="same_cdi_libretro.so"
PKG_LIBVAR="SAME_CDI_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
