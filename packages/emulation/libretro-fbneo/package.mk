# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fbneo"
PKG_VERSION="d48f1485e7052b97962594c18714de762214ae2b"
PKG_SHA256="d9cd7b2152f2fb50b9d4f457cd96a89e28961df79d19ae0df4b2f856df42092a"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/fbneo"
PKG_URL="https://github.com/libretro/FBNeo/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Final Burn Neo to Libretro"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="fbneo_libretro.so"
PKG_LIBPATH="src/burner/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="FBNEO_LIB"

PKG_MAKE_OPTS_TARGET="-C src/burner/libretro"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" profile=performance"

  if target_has_feature neon ; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi

  if [ "${PROJECT}" = "Rockchip" -a "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" USE_CYCLONE=1"
  fi

else
  PKG_MAKE_OPTS_TARGET+=" profile=accuracy"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  mkdir -p ${SYSROOT_PREFIX}/usr/share/libretro-database/fbneo
  cp -vr dats/* ${SYSROOT_PREFIX}/usr/share/libretro-database/fbneo

  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/fbneo
  cp metadata/hiscore.dat ${SYSROOT_PREFIX}/usr/share/retroarch/system/fbneo
}
