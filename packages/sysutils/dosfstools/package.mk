# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dosfstools"
PKG_VERSION="4.2"
PKG_SHA256="64926eebf90092dca21b14259a5301b7b98e7b1943e8a201c7d726084809b527"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/dosfstools/dosfstools"
PKG_URL="https://github.com/dosfstools/dosfstools/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host"
PKG_DEPENDS_INIT="autotools:host gcc:host"
PKG_LONGDESC="dosfstools contains utilities for making and checking MS-DOS FAT filesystems."
PKG_BUILD_FLAGS="-cfg-libs -cfg-libs:host -cfg-libs:init"

PKG_CONFIGURE_OPTS_TARGET="--enable-compat-symlinks"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

PKG_CONFIGURE_OPTS_INIT="--enable-compat-symlinks --without-iconv"
PKG_MAKE_OPTS_INIT="PREFIX=/usr"

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/sbin
    cp -P src/fsck.fat ${INSTALL}/usr/sbin
    ln -sf fsck.fat ${INSTALL}/usr/sbin/fsck.msdos
    ln -sf fsck.fat ${INSTALL}/usr/sbin/fsck.vfat
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/sbin
    cp src/mkfs.fat ${TOOLCHAIN}/sbin
    ln -sf mkfs.fat ${TOOLCHAIN}/sbin/mkfs.vfat
    cp src/fsck.fat ${TOOLCHAIN}/sbin
    ln -sf fsck.fat ${TOOLCHAIN}/sbin/fsck.vfat
    cp src/fatlabel ${TOOLCHAIN}/sbin
}
