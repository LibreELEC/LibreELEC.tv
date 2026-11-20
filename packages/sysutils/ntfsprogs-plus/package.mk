# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfsprogs-plus"
PKG_VERSION="3fe890434082973aa98fd441d65ae84e5d6e5fc8"
PKG_SHA256="05ef1472d8706d3633ce09bb3a10e691f72dc0a1d7d6c4b982ea40d9d296e898"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/ntfsprogs-plus/ntfsprogs-plus"
PKG_URL="https://github.com/ntfsprogs-plus/ntfsprogs-plus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libgcrypt"
PKG_LONGDESC="NTFS filesystem userspace utilities"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-library \
                           --exec-prefix=/usr"

post_configure_target() {
  libtool_remove_rpath libtool
}
