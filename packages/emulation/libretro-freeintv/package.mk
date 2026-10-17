# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-freeintv"
PKG_VERSION="428915baf2bfc032fc03e645f4f8f9c6c3144979"
PKG_SHA256="bc2826e362f78276c21f696c8bece86257d4a7be7484e96eaa79696016a3aac3"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/FreeIntv"
PKG_URL="https://github.com/libretro/FreeIntv/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeIntv is a libretro emulation core for the Mattel Intellivision."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="freeintv_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FREEINTV_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
