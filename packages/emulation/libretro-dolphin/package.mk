# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dolphin"
PKG_VERSION="0cd3bb89c29535db9b7552fc86871867ccf5b471"
PKG_SHA256="4be468f93f13ceaedcfb7bb350d06a6eaab6cc18232fb223c9cc7dffef07a7ec"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/dolphin"
# Built by tools/mkpkg/mkpkg_dolphin rather than taken from GitHub directly.
# Dolphin keeps its dependencies as git submodules and a GitHub archive
# contains none of them, so the build stops at the first add_subdirectory().
# The mkpkg tarball is the same sources with the twelve submodules this
# configuration cannot get any other way already in place.
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd bzip2 curl glslang hidapi libusb lz4 pugixml zlib zstd lzo xz libiconv"
PKG_LONGDESC="Dolphin is a GameCube and Wii emulator."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="dolphin_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="DOLPHIN_LIB"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DENABLE_QT=OFF \
                       -DENABLE_SDL=OFF \
                       -DENABLE_TESTS=OFF \
                       -DENABLE_TESTING=OFF \
                       -DUSE_DISCORD_PRESENCE=OFF \
                       -DENABLE_ANALYTICS=OFF \
                       -DENABLE_AUTOUPDATE=OFF \
                       -DENABLE_CLI_TOOL=OFF \
                       -DENABLE_LTO=OFF"

# AUTO rather than ON: Dolphin takes a system library wherever one is found and
# falls back to the copy under Externals otherwise, which is what the twelve
# bundled in the tarball are there for. ON makes any library it cannot find on
# the system a hard error, including the four -- mbedtls, LZO, liblzma and
# libiconv -- that Dolphin carries in its own tree rather than as submodules.
PKG_CMAKE_OPTS_TARGET+=" -DUSE_SYSTEM_LIBS=AUTO"

# The nine we do package are required rather than preferred. Under AUTO alone a
# library that stopped being found would quietly fall back to Externals, where
# the tarball deliberately has nothing, and the build would fail on a missing
# source directory rather than say which dependency went away.
PKG_CMAKE_OPTS_TARGET+=" -DUSE_SYSTEM_BZIP2=ON \
                         -DUSE_SYSTEM_CURL=ON \
                         -DUSE_SYSTEM_GLSLANG=ON \
                         -DUSE_SYSTEM_HIDAPI=ON \
                         -DUSE_SYSTEM_LIBUSB=ON \
                         -DUSE_SYSTEM_LZ4=ON \
                         -DUSE_SYSTEM_PUGIXML=ON \
                         -DUSE_SYSTEM_ZLIB=ON \
                         -DUSE_SYSTEM_ZSTD=ON"

# Kodi only negotiates OpenGL and OpenGL ES contexts with a game client, so the
# Vulkan backend can never be the one selected. Leaving it out also keeps two
# header-only submodules, Vulkan-Headers and VulkanMemoryAllocator, out of the
# tarball.
PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} libglvnd"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_EGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_EGL=ON"
fi

# No X11 on a GBM image, and the core probes for it rather than being told
if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_X11=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_X11=OFF"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp $(find ${PKG_BUILD}/.${TARGET_NAME} -name ${PKG_LIBNAME} | head -1) \
     ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
