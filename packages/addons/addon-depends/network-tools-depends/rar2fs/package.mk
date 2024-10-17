# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rar2fs"
PKG_VERSION="1.29.7"
PKG_SHA256="a875d138b7ed7e3353b5de2f0c5ec02ef6a32c310fe3b07886bc95314d7875ba"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/hasse69/rar2fs"
PKG_URL="https://github.com/hasse69/rar2fs/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse unrar"
PKG_LONGDESC="FUSE file system for reading RAR archives"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--with-unrar=${PKG_BUILD}/unrar \
                             --with-unrar-lib=${PKG_BUILD}/unrar \
                             --disable-static-unrar"
  cp -a $(get_install_dir unrar)/usr/include/unrar ${PKG_BUILD}/
  cp -p $(get_install_dir unrar)/usr/lib/libunrar.a ${PKG_BUILD}/unrar/
}
