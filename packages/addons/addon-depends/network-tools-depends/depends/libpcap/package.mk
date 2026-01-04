# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libpcap"
PKG_VERSION="1.10.6"
PKG_SHA256="872dd11337fe1ab02ad9d4fee047c9da244d695c6ddf34e2ebb733efd4ed8aa9"
PKG_LICENSE="GPL"
PKG_SITE="https://www.tcpdump.org/"
PKG_URL="https://www.tcpdump.org/release/libpcap-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A portable framework for low-level network monitoring."
# use configure, not cmake. review cmake in future release.
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="LIBS=-lpthread \
                           ac_cv_header_libusb_1_0_libusb_h=no \
                           --disable-shared \
                           --with-pcap=linux \
                           --disable-bluetooth \
                           --without-libnl \
                           --disable-dbus"

pre_configure_target() {
  # When cross-compiling, configure can't set linux version
  # forcing it
  sed -i -e 's/ac_cv_linux_vers=unknown/ac_cv_linux_vers=2/' ../configure
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
