# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-same_cdi"
PKG_VERSION="5c1e80d85b26d0ef91ab279a290a5dd07a2dc0ef"
PKG_SHA256="713da528d7ed99a0bef0ed66889c979549303d33ffe35aabc48f47186d22cb4f"
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
