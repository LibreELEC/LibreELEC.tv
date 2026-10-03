# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-yabasanshiro"
PKG_VERSION="f448097b69a6037246a08e9dc09eabaa420d7893"
PKG_SHA256="4b38c8d05a4a36333c81bf6dce18a7f4d1c38611ec23177211798bc8ee9af109"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Yaba Sanshiro is a Sega Saturn emulator, a fork of Yabause with a hardware renderer."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="yabasanshiro_libretro.so"
PKG_LIBPATH="yabause/src/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="YABASANSHIRO_LIB"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro platform=unix GIT_VERSION="

if build_with_debug; then
  PKG_MAKE_OPTS_TARGET+=" DEBUG=1"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  # glvnd provides libOpenGL here, not libGL: there is no GLX on a GBM build
  PKG_MAKE_OPTS_TARGET+=" GL_LIB=-lOpenGL"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
