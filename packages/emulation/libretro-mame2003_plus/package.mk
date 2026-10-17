# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003_plus"
PKG_VERSION="23c1680f562cdb745c6d7d87f436aff8c18ebbc6"
PKG_SHA256="8c3da06c5bb5a72d55d8c22cc12217463960b1f822d154ed51788d17c92ffcac"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2003_PLUS_LIB"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="ARCH= CC=${CC} NATIVE_CC=${CC} LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  mkdir -p ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus
  cp -v metadata/mame2003-plus.xml ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus/

  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples
  cp -rv metadata/artwork ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  cp -v metadata/{cheat,hiscore,history}.dat ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  # something must be in a folder in order to include it in the image, so why not some instructions
  echo "Put your samples here." >${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples/readme.txt
}
