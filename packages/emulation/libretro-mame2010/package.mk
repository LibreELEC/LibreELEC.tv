# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2010"
PKG_VERSION="70732f9137f6bb2bde4014746ea8bc613173dd1e"
PKG_SHA256="36ab11541233c9a4240baf6f0a529d8d335dce23f25b66b950e18373fd8e65fb"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="https://github.com/libretro/mame2010-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="Late 2010 version of MAME (0.139) for libretro"

PKG_LIBNAME="mame2010_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2010_LIB"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fpermissive"
  export CXXFLAGS="$CXXFLAGS -fpermissive"
  export LD="$CXX"

  case $TARGET_CPU in
    arm1176jzf-s)
      PKG_MAKE_OPTS_TARGET="platform=armv6-hardfloat-$TARGET_CPU"
      ;;
    cortex-a7|cortex-a9)
      PKG_MAKE_OPTS_TARGET="platform=armv7-neon-hardfloat-$TARGET_CPU"
      ;;
    *cortex-a53|cortex-a17)
      if [ "$TARGET_ARCH" = "aarch64" ]; then
        PKG_MAKE_OPTS_TARGET="platform=aarch64"
      else
        PKG_MAKE_OPTS_TARGET="platform=armv7-neon-hardfloat-cortex-a9"
      fi
      ;;
  esac
}

pre_make_target() {
  # precreate the build directories because they may be created too late
  make ${PKG_MAKE_OPTS_TARGET} maketree
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
