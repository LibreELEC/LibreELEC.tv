# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-o2em"
PKG_VERSION="44fe5f306033242f7d74144105e19a7d4939477e"
PKG_SHA256="0aaf148c82347827fcbcb2c66b5456d6eb021af218dd3e445ee08056320de28b"
PKG_LICENSE="Artistic-2.0"
PKG_SITE="https://github.com/libretro/libretro-o2em"
PKG_URL="https://github.com/libretro/libretro-o2em/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of O2EM to the libretro API, an Odyssey 2 / VideoPac emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="o2em_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="O2EM_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
