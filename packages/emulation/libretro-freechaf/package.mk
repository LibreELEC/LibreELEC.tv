# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-freechaf"
PKG_VERSION="cb499cd4c29d919e9da80442fa6178bf25c6bbb9"
PKG_SHA256="138775df617d709139e24378bf9f9b6f2f4705354f6817ac8158d3201684c20d"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/FreeChaF"
PKG_URL="https://github.com/kodi-game/FreeChaF/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeChaF is a libretro emulation core for the Fairchild Channel F / Video Entertainment System."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="freechaf_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FREECHAF_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
