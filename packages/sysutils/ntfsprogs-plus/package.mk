# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfsprogs-plus"
PKG_VERSION="07376d823679eeddce8e20a8675e66b48999c8ae"
PKG_SHA256="99532bfef9514d940615d552784e4a38f49ee6d1c03c0ae0523c893ca6d3f842"
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
