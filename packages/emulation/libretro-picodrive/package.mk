# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-picodrive"
PKG_VERSION="79c23b3d5765598ac1dfbf7de9a6650751ba13fe"
PKG_SHA256="60be6019154c09db808754bc8427f68d404fc6548a99c995441d4f0a6d9a0e3a"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="https://github.com/kodi-game/picodrive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ${PKG_NAME}:host"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="picodrive_libretro.so"
PKG_LIBPATH="../${PKG_LIBNAME}"
PKG_LIBVAR="PICODRIVE_LIB"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

make_host() {
  if [ "${ARCH}" != "x86_64" ]; then
    make -C ../cpu/cyclone CONFIG_FILE=../cyclone_config.h
  fi
}

makeinstall_host() {
  : # nothing to do
}

pre_make_target() {
  CFLAGS+=" -I./"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
