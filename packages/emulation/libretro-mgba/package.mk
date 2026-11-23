# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mgba"
PKG_VERSION="9fcaa882f25de40258f9578480854e590db12699"
PKG_SHA256="d03e138c25c5d88017ff304c439f9d5d2c2cff8cd34491255f9c409139f24108"
PKG_LICENSE="MPL-2.0"
PKG_SITE="https://github.com/mgba-emu/mgba"
PKG_URL="https://github.com/mgba-emu/mgba/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="mGBA Game Boy Advance Emulator"
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="mgba_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MGBA_LIB"

PKG_CMAKE_OPTS_TARGET="-DLIBMGBA_ONLY=ON \
                       -DBUILD_LIBRETRO=ON \
                       -DSKIP_LIBRARY=ON \
                       -DLIBRETRO_LIBDIR:PATH=lib/libretro"

pre_configure_target() {
  # mGBA reads its version from git; don't let it find the LibreELEC checkout
  export GIT_CEILING_DIRECTORIES="$(dirname ${PKG_BUILD})"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
