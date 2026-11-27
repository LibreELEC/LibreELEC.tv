# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-yabasanshiro"
PKG_VERSION="10f50efbbfed745757ce20d34ced7c80f06c68dd"
PKG_SHA256="5097d93ee1bd6236c927fa2c51aeab6a829d694e29180cc2c07df0b452b2e67c"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Yaba Sanshiro is a Sega Saturn emulator, a fork of Yabause with a hardware renderer."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="yabasanshiro_libretro.so"
PKG_LIBPATH="yabause/src/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="YABASANSHIRO_LIB"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro GIT_VERSION="

case "${TARGET_ARCH}" in
  aarch64)
    PKG_MAKE_OPTS_TARGET+=" platform=arm64"
    ;;
  arm)
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
    ;;
  *)
    PKG_MAKE_OPTS_TARGET+=" platform=unix"
    ;;
esac

if build_with_debug; then
  PKG_MAKE_OPTS_TARGET+=" DEBUG=1"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" GL_LIB=-lOpenGL"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
