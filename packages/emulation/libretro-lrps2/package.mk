# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-lrps2"
PKG_VERSION="e01fab211e38571094281fdeeba42f83575d5488"
PKG_SHA256="4e9c22b65d5aa8b27c8fe5a787f685c8747aa96e4ac777c8b74b3c693e0ee40b"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/LRPS2"
# The kodi-game fork rather than libretro/LRPS2, which no longer exists. This
# is the commit game.libretro.lrps2 pins, and it carries the 3rdparty tree as
# real directories, so an archive build has everything it needs -- unlike
# libretro-dolphin, which needs a git clone for its submodules.
PKG_URL="https://github.com/kodi-game/LRPS2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libpng xz libxml2 libaio"
PKG_LONGDESC="LRPS2 is a libretro port of the PCSX2 PlayStation 2 emulator."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="pcsx2_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="LRPS2_LIB"

# CMake 4 dropped compatibility with the <3.5 minimums this tree and its
# bundled libchdr and yaml-cpp still declare.
#
# ARCH_FLAG is set because the tree defaults it to -march=native, which is
# meaningless when cross compiling and would bake the build machine's ISA into
# the core. x86-64-v2 rather than the image-wide x86-64 baseline because
# PCSX2's GS renderer is written against SSE4.1 and has no SSE2 path left.
PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                       -DARCH_FLAG=-march=x86-64-v2"

# The GS renderer builds either way. Against desktop GL it asks for a 3.3 core
# profile; with HAVE_GLES (patch 0003) it asks for OpenGL ES 3.2 instead, which
# is what a default Generic device can serve. Prefer desktop GL where the image
# has it, since that path has had far more testing.
if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} libglvnd"
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  # The ES build still includes <GL/gl.h> and <GL/glext.h> for enums and the
  # PFNGL* typedefs -- it links libGLESv2, but the declarations come from the
  # desktop headers. mesa installs those even when built with OPENGL="no", so
  # a Generic sysroot has them; if that ever changes, the headers have to be
  # vendored rather than the renderer rewritten.
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DHAVE_GLES=ON"
else
  die "${PKG_NAME} needs either OpenGL or OpenGL ES"
fi

pre_configure_target() {
  # BuildParameters.cmake seeds CMAKE_C_FLAGS/CMAKE_CXX_FLAGS from the
  # environment and appends its own, so these survive. They are passed here
  # rather than through ARCH_FLAG because PKG_CMAKE_OPTS_TARGET is expanded
  # unquoted and a flag containing spaces would be split into separate
  # arguments.
  #
  # -include stdint.h: the uint16_t/uint32_t uses gcc 13+ no longer supplies
  # transitively, bundled yaml-cpp mainly. -mfxsr: PCSX2 uses the fxsave and
  # fxrstor intrinsics directly.
  #
  # -std=gnu++17: the bundled wxWidgets 3.0 streams wchar_t* into a narrow
  # ostream, and that overload is deleted from C++20 onward, so anything newer
  # stops at "use of deleted function 'std::operator<<'". The core target asks
  # for cxx_std_17 already; this brings the 3rdparty subprojects with it.
  export CFLAGS="${CFLAGS} -mfxsr -include stdint.h"
  export CXXFLAGS="${CXXFLAGS} -mfxsr -include stdint.h -std=gnu++17"

  # xz is built "+pic -sysroot", so nothing lands where find_package(LibLZMA)
  # looks and the tree falls back to its bundled copy -- a 2020 snapshot whose
  # mythread.h picks the win32 backend under this toolchain and stops at
  # "windows.h: No such file or directory". Point CMake at the real one.
  # PKG_CMAKE_OPTS_TARGET is expanded after this hook runs, so appending works.
  PKG_CMAKE_OPTS_TARGET+=" -DLIBLZMA_LIBRARY=$(get_install_dir xz)/usr/lib/liblzma.a"
  PKG_CMAKE_OPTS_TARGET+=" -DLIBLZMA_INCLUDE_DIR=$(get_install_dir xz)/usr/include"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp $(find ${PKG_BUILD}/.${TARGET_NAME} -name ${PKG_LIBNAME} | head -1) \
     ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
