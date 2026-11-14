# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-melonds"
PKG_VERSION="66b5d2634cd0a79030562811e6e05f5532f800ba"
PKG_SHA256="8fa494f12a8fe7f20a4ab32ac89a1391f079d41a203d02822b8541e71637a22c"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/melonDS"
PKG_URL="https://github.com/libretro/melonDS/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="melonDS is a Nintendo DS emulator, focused on accuracy and performance."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="melonds_libretro.so"
PKG_LIBPATH="../${PKG_LIBNAME}"
PKG_LIBVAR="MELONDS_LIB"

PKG_MAKE_OPTS_TARGET="-C ../ platform=unix"

if build_with_debug; then
  PKG_MAKE_OPTS_TARGET+=" DEBUG=1"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

pre_make_target() {
  export LDFLAGS="${LDFLAGS} -Wl,-z,noexecstack"
}

make_target() {
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    make ${PKG_MAKE_OPTS_TARGET} HAVE_OPENGL=1 LIBS="-lm -lpthread -lrt -lOpenGL"
  else
    make ${PKG_MAKE_OPTS_TARGET} HAVE_OPENGL=0 LIBS="-lm -lpthread -lrt"
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
