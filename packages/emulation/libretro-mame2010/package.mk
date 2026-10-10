# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2010"
PKG_VERSION="cc63285e2109263da4eca0911ba07aec60b8109b"
PKG_SHA256="468b8b3bb35270953283b74eb915ecbaa7630f3ec8935e9f9d1efcaf0a6581cc"
PKG_LICENSE="LicenseRef-MAME"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="https://github.com/libretro/mame2010-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="Late 2010 version of MAME (0.139) for libretro. Compatible with MAME 0.139 romsets."
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="mame2010_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2010_LIB"

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
  PKG_MAKE_OPTS_TARGET="CC=${CC} LD=${CC}"
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" PTR64=0 ARM_ENABLED=1 LCPU=arm"
  elif [ "${ARCH}" = "x86_64" ]; then
    PKG_MAKE_OPTS_TARGET+=" PTR64=1 ARM_ENABLED=0 LCPU=x86_64"
  elif [ "${ARCH}" = "aarch64" ]; then
    PKG_MAKE_OPTS_TARGET+=" PTR64=1 ARM_ENABLED=1 LCPU=arm64"
  fi
  make ${PKG_MAKE_OPTS_TARGET} PLATCFLAGS="${CFLAGS}" maketree
}

make_target() {
  make ${PKG_MAKE_OPTS_TARGET} PLATCFLAGS="${CFLAGS}"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  mkdir -p ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2010
  cp -v metadata/mame2010.xml ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2010/
}
