# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-a5200"
PKG_VERSION="0942c88d64cad6853b539f51b39060a9de0cbcab"
PKG_SHA256="cb84b9f158510f0b2e5f687f249f103ab26c322f4b3971935b08af70c426464b"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/libretro/a5200"
PKG_URL="https://github.com/libretro/a5200/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Atari 5200 emulator version 2.0.2 for GCW0"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="a5200_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="A5200_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
