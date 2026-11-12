# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-picodrive"
PKG_VERSION="92c8634e9c8aa59a5cf54d7a8ac53822b603d5e8"
PKG_SHA256="80e2a3896bb949f5583ac621e071f6a09952506dfa2eb33ded8fe6c7c1c2ebbf"
PKG_LICENSE="LicenseRef-MAME"
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
  MAKEFLAGS+=" GIT_REVISION=-${PKG_VERSION:0:7}"
  CFLAGS+=" -I./"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
