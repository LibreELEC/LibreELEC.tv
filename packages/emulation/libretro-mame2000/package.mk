# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2000"
PKG_VERSION="181b42e5da0d2f0c7a2e59244f23633ed594de2e"
PKG_SHA256="5420ee002c68afda1c54479ba1b80a4810705d7f4c18e5b6165bfd978968152e"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/libretro/mame2000-libretro"
PKG_URL="https://github.com/libretro/mame2000-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2000_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2000_LIB"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET="ARM=1 USE_CYCLONE=1 USE_DRZ80=1"
fi

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
