# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libaio"
PKG_VERSION="0.3.113"
PKG_SHA256="2c44d1c5fd0d43752287c9ae1eb9c023f04ef848ea8d4aafa46e9aedb678200b"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="https://codeberg.org/jmoyer/libaio"
PKG_URL="https://codeberg.org/jmoyer/libaio/releases/download/libaio-${PKG_VERSION}/libaio-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="make:host gcc:host"
PKG_LONGDESC="Kernel Asynchronous I/O (AIO) Support for Linux."

make_target() {
  make -C src
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp -PR src/libaio.a ${SYSROOT_PREFIX}/usr/lib

  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -PR src/libaio.h ${SYSROOT_PREFIX}/usr/include
}
