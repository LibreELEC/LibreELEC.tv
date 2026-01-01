# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mupen64plus-nx"
PKG_VERSION="222acbd3f98391458a047874d0372fe78e14fe94"
PKG_SHA256="9e55fa83f2313f9b80a369d77457ec216e5774ef2d486083ad8661aa94a4dbd1"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="https://github.com/kodi-game/mupen64plus-libretro-nx/archive/${PKG_VERSION}.tar.gz"
PKG_BRANCH="develop"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Improved mupen64plus libretro core reimplementation"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mupen64plus_next_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MUPEN64PLUS-NS_LIB"

if build_with_debug; then
  PKG_MAKE_OPTS_TARGET+=" DEBUG=1"
fi

PLATFORM=""

case "${DEVICE}" in
  RPi)
    #mupen64plus-nx auto detects rpi4 for gles3 but not rpi5
    case "${DEVICE:-${PROJECT}}" in
      RPi)  PLATFORM="rpi" ;;
      RPi2) PLATFORM="rpi2" ;;
      RPi4) PLATFORM="rpi4_64" ;;
      RPi5) PLATFORM="rpi5_64" ;;
    esac
    ;;
  Generic|*)
    # Tested only with "Generic"
    PLATFORM="unix"
    PKG_MAKE_OPTS_TARGET+=" HAVE_THR_AL=1 HAVE_PARALLEL_RDP=1 LLE=1 HAVE_PARALLEL_RSP=1"
    ;;
esac

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" GL_LIB=-lOpenGL"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PLATFORM+="-mesa"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES3=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ -n "${PLATFORM}" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=${PLATFORM}"
fi

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
