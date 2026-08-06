# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-neocd"
PKG_VERSION="9e9ad181bed60f84f9cff02c03617b41e8a31cfe"
PKG_SHA256="287e16da9c70f5d0797439b6da6583d191027f25dcf6c719d5890539966e6194"
PKG_LICENSE="LGPL-3.0-only"
PKG_SITE="https://github.com/libretro/neocd_libretro"
PKG_URL="https://github.com/libretro/neocd_libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="NeoCD is a libretro emulation core for the SNK Neo Geo CD."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="neocd_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="NEOCD_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
