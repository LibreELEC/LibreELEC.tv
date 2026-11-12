# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2010"
PKG_VERSION="dff8aadd1c3f38215af3955746d6e19abe0ddcea"
PKG_SHA256="ef62ec2884a18b0af64ad35a96d7622253793d5c93db315d9c1a2f2c021ae72a"
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
