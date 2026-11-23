# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-headers"
PKG_VERSION="1.4.369"
PKG_SHA256="a63c6efc6f611e46aa83d65947398d548a718d3a32075e7b2238a930b3a42ced"
PKG_LICENSE="Apache-2.0 OR MIT"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Headers"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Headers/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Vulkan Header files and API registry"

post_makeinstall_target() {
  safe_remove "${INSTALL}/usr/share"
} 
