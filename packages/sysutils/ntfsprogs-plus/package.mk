# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfsprogs-plus"
PKG_VERSION="c11c1f69968dd169203729a6e25eaf5af0fcad8a"
PKG_SHA256="fe14e374373ee427643d3d0bbedcfa19f37ecd1628d4b9e78565f4002c1f1d25"
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
