# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-gba"
PKG_VERSION="b158166237b17253188cfdbe73a8a0b9fe4b3a8c"
PKG_SHA256="9633e42ca3fb4acd3f9d6d3b6e9ca24765df0a863f688bb84fac4b767587f5da"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/beetle-gba-libretro"
PKG_URL="https://github.com/libretro/beetle-gba-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen gba"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mednafen_gba_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="BEETLE-GBA_LIB"

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
