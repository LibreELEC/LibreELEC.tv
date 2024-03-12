# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bsnes-hd"
PKG_VERSION="f46b6d6368ea93943a30b5d4e79e8ed51c2da5e8"
PKG_SHA256="d46ee8fdf68d971536ee3edc6f48917a83dc9c919583e58ec0abe78724401e8f"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/DerKoun/bsnes-hd"
PKG_URL="https://github.com/DerKoun/bsnes-hd/archive/${PKG_VERSION}.tar.gz"
PKG_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Fork of bsnes that adds HD video features."
PKG_TOOLCHAIN="make"

make_target() {
  make -C bsnes -f GNUmakefile target="libretro" compiler="${CXX}" CXXFLAGS="${CXXFLAGS}" platform=linux local=false binary=library
}

PKG_LIBNAME="bsnes_hd_beta_libretro.so"
PKG_LIBPATH="bsnes/out/${PKG_LIBNAME}"
PKG_LIBVAR="BSNES-HD_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
