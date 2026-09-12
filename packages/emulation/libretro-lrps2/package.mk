# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-lrps2"
PKG_VERSION="e01fab211e38571094281fdeeba42f83575d5488"
PKG_SHA256="4e9c22b65d5aa8b27c8fe5a787f685c8747aa96e4ac777c8b74b3c693e0ee40b"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/LRPS2"
PKG_URL="https://github.com/kodi-game/LRPS2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libpng xz libxml2 libaio"
PKG_LONGDESC="LRPS2 is a libretro port of the PCSX2 PlayStation 2 emulator."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="pcsx2_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="LRPS2_LIB"

# ARCH_FLAG: the tree defaults it to -march=native. x86-64-v2 because the GS
# renderer requires SSE4.1.
PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                       -DARCH_FLAG=-march=x86-64-v2"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} libglvnd"
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DHAVE_GLES=ON"
else
  die "${PKG_NAME} needs either OpenGL or OpenGL ES"
fi

pre_configure_target() {
  # -include stdint.h for the bundled yaml-cpp, -mfxsr for the fxsave and
  # fxrstor intrinsics, -std=gnu++17 for the bundled wxWidgets 3.0.
  export CFLAGS="${CFLAGS} -mfxsr -include stdint.h"
  export CXXFLAGS="${CXXFLAGS} -mfxsr -include stdint.h -std=gnu++17"

  # xz is built "+pic -sysroot", so find_package(LibLZMA) misses it and the
  # tree falls back to its bundled 2020 copy, which does not build here.
  PKG_CMAKE_OPTS_TARGET+=" -DLIBLZMA_LIBRARY=$(get_install_dir xz)/usr/lib/liblzma.a"
  PKG_CMAKE_OPTS_TARGET+=" -DLIBLZMA_INCLUDE_DIR=$(get_install_dir xz)/usr/include"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp $(find ${PKG_BUILD}/.${TARGET_NAME} -name ${PKG_LIBNAME} | head -1) \
     ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
