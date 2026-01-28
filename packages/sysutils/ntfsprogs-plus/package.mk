# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfsprogs-plus"
PKG_VERSION="2211e0ba15a25306c08aec35021df1867c0fcd26"
PKG_SHA256="82989ef143fbfaf3fd3bb5de7aca27008b04d5500e9d798f7ac5dd525d986152"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/ntfsprogs-plus/ntfsprogs-plus"
PKG_URL="https://github.com/ntfsprogs-plus/ntfsprogs-plus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libgcrypt"
PKG_LONGDESC="NTFS filesystem userspace utilities"
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  rm ${INSTALL}/usr/lib/libntfs.so
  mv ${INSTALL}/lib/libntfs.so* ${INSTALL}/usr/lib/
  rmdir ${INSTALL}/lib
}
