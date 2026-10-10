# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vecx"
PKG_VERSION="8f671cc9d737f2890c3ce19e177e2984dcae121f"
PKG_SHA256="cd59fe10619be54c60bb6feb2f48c607291f38bd9638b78ee975081d80450065"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/libretro/libretro-vecx"
PKG_URL="https://github.com/libretro/libretro-vecx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro adaptation of vecx"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="vecx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="VECX_LIB"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ] &&
   [ "${DISPLAYSERVER}" != "x11" ]; then
  PKG_MAKE_OPTS_TARGET+=" USE_GLVND=1"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${PROJECT}" = "RPi" ]; then
  if [ "${OPENGLES}" = "mesa" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi-mesa"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=rpi"
  fi
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAS_GLES=1 GLES=1"
fi

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
