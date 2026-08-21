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
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MELONDS_LIB"

# melonDS also ships a CMakeLists.txt, for its standalone build. Leaving that
# where the build script looks sends the whole build out-of-tree, and the
# libretro Makefile is not out there, so point the probe somewhere it finds none
PKG_CMAKE_SCRIPT="${PKG_BUILD}/no-cmake"

PKG_MAKE_OPTS_TARGET="platform=unix"

if build_with_debug; then
  PKG_MAKE_OPTS_TARGET+=" DEBUG=1"
fi

# melonDS' OpenGL renderer is desktop GL only -- its Makefile.common gates the
# renderer on HAVE_OPENGL and links glsym_gl.c, and the HAVE_OPENGLES3 its
# platform table sets is never read. So take OpenGL where the project provides
# it, and the software renderer everywhere else (DS runs well on it)
if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  # glvnd provides libOpenGL here, not libGL: there is no GLX on a GBM build
  PKG_MAKE_OPTS_TARGET+=" GL_LIB=-lOpenGL"
else
  PKG_MAKE_OPTS_TARGET+=" DISABLE_OPENGL=1"
fi

pre_make_target() {
  # The core's assembly sources carry no .note.GNU-stack, so the linker marks
  # the whole library as needing an executable stack (GNU_STACK RWE), and Kodi
  # cannot load it at all:
  #
  #   cannot enable executable stack as shared object requires: Invalid argument
  #
  # The JIT maps its own executable pages and never runs code from the stack,
  # so asking for a non-executable one costs nothing.
  export LDFLAGS="${LDFLAGS} -Wl,-z,noexecstack"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
