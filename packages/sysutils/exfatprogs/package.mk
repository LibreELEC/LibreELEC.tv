# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="exfatprogs"
PKG_VERSION="1.4.5"
PKG_SHA256="68464a07d90e9fda5475df68800b88eac2bc76076d157fd13cd8d936e0c369b0"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/exfatprogs/exfatprogs"
PKG_URL="https://github.com/exfatprogs/exfatprogs/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="userspace utilities that contain all of the standard utilities for creating and fixing and debugging exfat filesystems."
PKG_TOOLCHAIN="autotools"

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share
}
