# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-quicknes"
PKG_VERSION="058d66516ed3f1260b69e5b71cd454eb7e9234a3"
PKG_SHA256="dabc554bdfdb5f51fec733b0752b6803557c1ac8e8ab6f087f84991470b376f6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="https://github.com/libretro/QuickNES_Core/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The QuickNES core library, originally by Shay Green, heavily modified"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="quicknes_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="QUICKNES_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
