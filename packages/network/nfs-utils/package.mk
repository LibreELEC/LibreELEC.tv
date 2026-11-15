# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nfs-utils"
PKG_VERSION="3.1.1"
PKG_SHA256="7dbc05eb8b32828b322872b759a62cb3979cb4118f344dd8616813d1390e84e0"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://www.linux-nfs.org/"
PKG_URL="https://www.kernel.org/pub/linux/utils/nfs-utils/${PKG_VERSION}/nfs-utils-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain keyutils libevent libnl libtirpc libxml2 readline rpcbind sqlite util-linux"
PKG_LONGDESC="Linux NFS userland utility package"

PKG_CONFIGURE_OPTS_TARGET="--disable-gss \
                           --disable-nfsv41 \
                           --disable-nfsdcld \
                           --disable-nfsrahead \
                           --disable-nfsdcltrack \
                           --disable-ldap"

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}

  # libreadline.so is not linked against (the static) ncurses; nfsdctl must
  # resolve the termcap symbols itself. ld.gold does not check undefined
  # symbols of shared libraries, ld.bfd (riscv64) does.
  export LIBS="${LIBS} -lncursesw"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/sbin/"
    cp -PR utils/mount/mount.nfs "${INSTALL}/usr/sbin/"
    ln -s mount.nfs "${INSTALL}/usr/sbin/mount.nfs4"
    ln -s mount.nfs "${INSTALL}/usr/sbin/umount.nfs"
    ln -s mount.nfs "${INSTALL}/usr/sbin/umount.nfs4"
}
