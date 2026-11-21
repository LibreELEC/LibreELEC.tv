# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-flycast"
PKG_VERSION="8b8ae4caf1a5ae8c68bbe104770c28ed1ef58b6e"
PKG_SHA256="506ffd86d0bb797bba0d5727463c8981f7ebc6217f7b8e3f47aa5e4d1aa94fe7"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/flycast"
PKG_URL="https://github.com/kodi-game/flycast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="Flycast is a Sega Dreamcast, Naomi and Atomiswave emulator."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="flycast_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FLYCAST_LIB"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DUSE_VULKAN=OFF \
                       -DUSE_OPENMP=OFF \
                       -DUSE_HOST_LIBZIP=OFF \
                       -DUSE_ALSA=OFF \
                       -DUSE_LIBAO=OFF \
                       -DUSE_PULSEAUDIO=OFF \
                       -DUSE_BREAKPAD=OFF \
                       -DUSE_LUA=OFF \
                       -DUSE_DX9=OFF \
                       -DUSE_DX11=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
