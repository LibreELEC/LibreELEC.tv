# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-lrps2"
PKG_VERSION="d4908f40fb32f43c5055852ecaed3c52aa725dce"
PKG_SHA256="e2756b4d650cbd15912d7ead03b8f97147247c50e76ec7652efd7d9e79eb0fd1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/parallel-ps2"
PKG_URL="https://github.com/libretro/parallel-ps2/archive/${PKG_VERSION}.tar.gz"
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
