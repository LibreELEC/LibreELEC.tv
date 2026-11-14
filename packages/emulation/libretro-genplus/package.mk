# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-genplus"
PKG_VERSION="60bee4c724859710ce05672239e5b601ad01382e"
PKG_SHA256="be38862ff269dfb69c543fbd4219c1883f18f9de99d00164040b40d6e5b3a844"
PKG_LICENSE="LicenseRef-Non-commercial"
PKG_SITE="https://github.com/ekeeke/Genesis-Plus-GX"
PKG_URL="https://github.com/libretro/Genesis-Plus-GX/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Genesis Plus GX is an open-source & portable Sega Mega Drive / Genesis emulator, now also emulating SG-1000, Master System, Game Gear and Sega/Mega CD hardware."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="genesis_plus_gx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="GENPLUS_LIB"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" NO_OPTIMIZE=1"
fi

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
  if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
    CFLAGS+=" -DALIGN_LONG"
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
