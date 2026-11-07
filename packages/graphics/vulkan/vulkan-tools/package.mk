# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-tools"
PKG_VERSION="1.4.368"
PKG_SHA256="d7d7f312db38d7b1658bfa1b3b0104c86c456eda175c1b8cccf64a16408926a0"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Tools"
PKG_URL="https://github.com/KhronosGroup/Vulkan-tools/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain volk vulkan-loader glslang:host Python3:host"
PKG_LONGDESC="This project provides Khronos official Vulkan Tools and Utilities."

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libxcb libX11"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DVULKAN_HEADERS_INSTALL_DIR=${SYSROOT_PREFIX}/usr \
                         -DBUILD_VULKANINFO=ON \
                         -DBUILD_ICD=OFF \
                         -DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
                         -Wno-dev"

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_CUBE=ON \
                             -DCOMPILE_CUBE_SHADERS=ON \
                             -DBUILD_WSI_XCB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_SUPPORT=ON \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
                             -DCUBE_WSI_SELECTION=XCB"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_CUBE=ON \
                             -DCOMPILE_CUBE_SHADERS=ON \
                             -DBUILD_WSI_XCB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_SUPPORT=OFF \
                             -DBUILD_WSI_WAYLAND_SUPPORT=ON \
                             -DCUBE_WSI_SELECTION=WAYLAND"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_CUBE=ON \
                             -DCOMPILE_CUBE_SHADERS=ON \
                             -DBUILD_WSI_XCB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_SUPPORT=OFF \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
                             -DCUBE_WSI_SELECTION=DISPLAY"
  fi
}

pre_make_target() {
  # Fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed -i  "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

post_makeinstall_target() {
  # Clean up - two graphic test tools are superfluous
  safe_remove ${INSTALL}/usr/bin/vkcubepp
}
