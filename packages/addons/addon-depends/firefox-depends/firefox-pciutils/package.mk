# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="firefox-pciutils"
PKG_VERSION="3.14.0"
PKG_SHA256="e7713409882813991d2269d125e40dad1f54a019a52b78b3962941c1d4a6f86f"
PKG_LICENSE="GPL"
PKG_SITE="http://mj.ucw.cz/pciutils.shtml"
PKG_URL="https://www.kernel.org/pub/software/utils/pciutils/pciutils-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain kmod systemd"
PKG_LONGDESC="Utilities for inspecting devices connected to the PCI bus and the PCI vendor/product ID database."

PKG_MAKE_OPTS="PREFIX=/usr SHARED=yes STRIP= IDSDIR=/usr/share"

make_target() {
  make OPT="${CFLAGS}" \
       CROSS_COMPILE=${TARGET_PREFIX} \
       HOST=${TARGET_ARCH}-linux \
       ${PKG_MAKE_OPTS} \
       ZLIB=no DNS=no LIBKMOD=yes HWDB=yes
}

makeinstall_target() {
  make ${PKG_MAKE_OPTS} DESTDIR=${SYSROOT_PREFIX} install
  make ${PKG_MAKE_OPTS} DESTDIR=${SYSROOT_PREFIX} install-lib
  make ${PKG_MAKE_OPTS} DESTDIR=${INSTALL} install-lib
  make ${PKG_MAKE_OPTS} DESTDIR=${INSTALL} install
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/sbin/setpci
  rm -rf ${INSTALL}/usr/sbin/update-pciids
  rm -rf ${INSTALL}/usr/share
}
