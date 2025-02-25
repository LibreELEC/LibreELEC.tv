# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-swanstation"
PKG_VERSION="929958a1acaa075e32e108118b550e0449540cb6"
PKG_SHA256="fb8e0dc07c3e8b662af5f40137796a65e6e291fb752912092071b6e9d9555409"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="https://github.com/libretro/swanstation/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SwanStation is a Libretro core implementation of DuckStation, which is an emulator of the Sony PlayStation console."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="swanstation_libretro.so"
PKG_LIBPATH="./${PKG_LIBNAME}"
PKG_LIBVAR="SWANSTATION_LIB"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

PKG_CMAKE_OPTS_TARGET="-DBUILD_NOGUI_FRONTEND=OFF \
                       -DBUILD_QT_FRONTEND=OFF \
                       -DBUILD_LIBRETRO_CORE=ON \
                       -DENABLE_DISCORD_PRESENCE=OFF \
                       -DUSE_DRMKMS=ON"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
