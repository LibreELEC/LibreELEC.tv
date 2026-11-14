# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003_plus"
PKG_VERSION="90149e76d23181228e148794067484a84bf00d54"
PKG_SHA256="337f45376aba809bc626a5dac585e6e18fded4c6e4ea3b6cc1a285de51fb6903"
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
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
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
