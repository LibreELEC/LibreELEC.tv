# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-lrps2"
PKG_VERSION="eecc1824f71697eb31d3cc017f62f3b5204b3c7b"
PKG_SHA256="f423d7edd14912a5af59898f3fd9ecc35e0a711f5ae813042f39abb7418a3ebc"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/ps2"
PKG_URL="https://github.com/libretro/ps2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="LRPS2 is a libretro port of the PCSX2 PlayStation 2 emulator."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="pcsx2_libretro.so"
PKG_LIBPATH="bin/${PKG_LIBNAME}"
PKG_LIBVAR="LRPS2_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
