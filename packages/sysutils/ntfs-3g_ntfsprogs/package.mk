# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfs-3g_ntfsprogs"
PKG_VERSION="2022.10.3"
PKG_SHA256="f20e36ee68074b845e3629e6bced4706ad053804cbaf062fbae60738f854170c"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tuxera/ntfs-3g"
PKG_URL="https://tuxera.com/opensource/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain fuse libgcrypt"
PKG_LONGDESC="A NTFS driver with read and write support."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--exec-prefix=/usr/ \
                           --disable-dependency-tracking \
                           --disable-library \
                           --enable-posix-acls \
                           --enable-mtab \
                           --enable-ntfsprogs \
                           --disable-crypto \
                           --with-fuse=external \
                           --with-uuid \
                           --disable-mount-helper \
                           --disable-ldconfig"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/.noinstall
  for i in ${INSTALL}/usr/{bin,sbin}/*; do
    if ! listcontains "ntfs-3g.probe ntfsfix" $(basename "${i}"); then
      mv ${i} ${INSTALL}/.noinstall
    fi
  done
}
