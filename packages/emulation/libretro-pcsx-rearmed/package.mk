# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-pcsx-rearmed"
PKG_VERSION="c8816799b50388e61cfe237fe2cdbb7d8175f20a"
PKG_SHA256="edeb21fdeef8815521cb9d4488d2cd35746607c968ca9b26cce4e42c09f2dc99"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="pcsx_rearmed_libretro.so"
PKG_LIBPATH="../${PKG_LIBNAME}"
PKG_LIBVAR="PCSX-REARMED_LIB"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" DYNAREC=ari64"
  if target_has_feature neon; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON_ASM=1 BUILTIN_GPU=neon"
  else
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON_ASM=0 BUILTIN_GPU=unai"
  fi
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    sed -e "s|armv8-a|armv8-a+crc|" \
        -i ../Makefile.libretro
    PKG_MAKE_OPTS_TARGET+=" platform=classic_armv8_a35"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=unix"
  fi
elif [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=unix DYNAREC=ari64"
else
  PKG_MAKE_OPTS_TARGET+=" platform=unix DYNAREC=none"
fi

pre_make_target() {
  MAKEFLAGS+=" GIT_VERSION=\"\\ ${PKG_VERSION:0:7}\""
  echo "#define REV \"${PKG_VERSION:0:7}\"" >${PKG_BUILD}/include/revision.h
  MAKEFLAGS+=" --assume-old=include/revision.h"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
