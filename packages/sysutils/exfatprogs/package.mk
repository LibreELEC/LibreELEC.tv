# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="exfatprogs"
PKG_VERSION="1.2.8"
PKG_SHA256="d742b17af7b09370b9334deff167222f21720577c6eea3f9b3c51770ac544516"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/exfatprogs/exfatprogs"
PKG_URL="https://github.com/exfatprogs/exfatprogs/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="userspace utilities that contain all of the standard utilities for creating and fixing and debugging exfat filesystems."
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share
}
