# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="e2fsprogs"
PKG_VERSION="1.45.7"
PKG_SHA256="62d49c86d9d4becf305093edd65464484dc9ea41c6ff9ae4f536e4a341b171a2"
PKG_LICENSE="GPL"
PKG_SITE="http://e2fsprogs.sourceforge.net/"
PKG_URL="https://www.kernel.org/pub/linux/kernel/people/tytso/${PKG_NAME}/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_LONGDESC="The filesystem utilities for the EXT2 filesystem, including e2fsck, mke2fs, dumpe2fs, fsck, and others."
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_HOST="--prefix=${TOOLCHAIN}/ \
                         --bindir=${TOOLCHAIN}/bin \
                         --with-udev-rules-dir=no \
                         --with-crond-dir=no \
                         --with-systemd-unit-dir=no \
                         --sbindir=${TOOLCHAIN}/sbin \
                         --enable-verbose-makecmds \
                         --disable-symlink-install \
                         --disable-symlink-build \
                         --disable-subset \
                         --disable-debugfs \
                         --disable-imager \
                         --disable-resizer \
                         --disable-defrag \
                         --disable-fsck \
                         --disable-e2initrd-helper \
                         --enable-tls \
                         --disable-uuidd \
                         --disable-nls \
                         --disable-rpath \
                         --disable-fuse2fs \
                         --with-gnu-ld"

pre_configure() {
  PKG_CONFIGURE_OPTS_INIT="BUILD_CC=${HOST_CC} \
                           --with-udev-rules-dir=no \
                           --with-crond-dir=no \
                           --with-systemd-unit-dir=no \
                           --enable-verbose-makecmds \
                           --enable-symlink-install \
                           --enable-symlink-build \
                           --disable-subset \
                           --disable-elf-shlibs \
                           --disable-bsd-shlibs \
                           --disable-profile \
                           --disable-jbd-debug \
                           --disable-blkid-debug \
                           --disable-testio-debug \
                           --enable-libuuid \
                           --enable-libblkid \
                           --disable-debugfs \
                           --disable-imager \
                           --enable-resizer \
                           --enable-fsck \
                           --disable-e2initrd-helper \
                           --enable-tls \
                           --disable-uuidd \
                           --disable-nls \
                           --disable-rpath \
                           --disable-fuse2fs \
                           --with-gnu-ld"

  PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_INIT}"
}

post_makeinstall_target() {
  make -C lib/et LIBMODE=644 DESTDIR=${SYSROOT_PREFIX} install

  rm -rf ${INSTALL}/usr/sbin/badblocks
  rm -rf ${INSTALL}/usr/sbin/blkid
  rm -rf ${INSTALL}/usr/sbin/dumpe2fs
  rm -rf ${INSTALL}/usr/sbin/e2freefrag
  rm -rf ${INSTALL}/usr/sbin/e2undo
  rm -rf ${INSTALL}/usr/sbin/e4defrag
  rm -rf ${INSTALL}/usr/sbin/filefrag
  rm -rf ${INSTALL}/usr/sbin/fsck
  rm -rf ${INSTALL}/usr/sbin/logsave
  rm -rf ${INSTALL}/usr/sbin/mklost+found
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/sbin
    cp e2fsck/e2fsck ${INSTALL}/usr/sbin
    ln -sf e2fsck ${INSTALL}/usr/sbin/fsck.ext2
    ln -sf e2fsck ${INSTALL}/usr/sbin/fsck.ext3
    ln -sf e2fsck ${INSTALL}/usr/sbin/fsck.ext4

  if [ ${INITRAMFS_PARTED_SUPPORT} = "yes" ]; then
    cp misc/mke2fs ${INSTALL}/usr/sbin
    ln -sf mke2fs ${INSTALL}/usr/sbin/mkfs.ext2
    ln -sf mke2fs ${INSTALL}/usr/sbin/mkfs.ext3
    ln -sf mke2fs ${INSTALL}/usr/sbin/mkfs.ext4
  fi
}

makeinstall_host() {
  make -C lib/et LIBMODE=644 install
  make -C lib/ext2fs LIBMODE=644 install
  mkdir -p ${TOOLCHAIN}/sbin
  cp e2fsck/e2fsck ${TOOLCHAIN}/sbin
  cp misc/mke2fs ${TOOLCHAIN}/sbin
  cp misc/tune2fs ${TOOLCHAIN}/sbin
}
