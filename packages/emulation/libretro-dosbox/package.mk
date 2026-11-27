# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dosbox"
PKG_VERSION="a563bb5e9753f207d74e9d8c417d793b784fa4be"
PKG_SHA256="f25821af18acd6ca6598d2366e2d0d9bf901b1111f35142d99b815b238baa44d"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/dosbox-libretro"
PKG_URL="https://github.com/libretro/dosbox-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib fluidsynth libogg libvorbis mpg123 opus opusfile"
PKG_DEPENDS_CONFIG="mpg123 opusfile"
PKG_LONGDESC="libretro wrapper for the DOSBox emulator"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="dosbox_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"
PKG_LIBVAR="DOSBOX_LIB"

PKG_MAKE_OPTS_TARGET="-C libretro -f Makefile.libretro platform=unix \
                      BUNDLED_SDL=1 \
                      BUNDLED_AUDIO_CODECS=0 \
                      BUNDLED_FLUIDSYNTH=0 \
                      TARGET_TRIPLET=${TARGET_NAME} \
                      cross_prefix= \
                      PKG_CONFIG_FLAGS=--static"

case "${TARGET_ARCH}" in
  aarch64)
    PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=arm64"
    ;;
  arm)
    PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=arm"
    ;;
  x86_64)
    PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=x86_64"
    ;;
esac

pre_make_target() {
  export CMAKE_TOOLCHAIN_FILE="${CMAKE_CONF}"
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
