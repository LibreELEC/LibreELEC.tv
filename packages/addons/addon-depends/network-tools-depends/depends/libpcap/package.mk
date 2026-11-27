# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libpcap"
PKG_VERSION="1.11.1"
PKG_SHA256="7985b1d20ff82c1e384115038046e0b15034648c6f45c92e08601d4ee1b369ed"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://www.tcpdump.org/"
PKG_URL="https://www.tcpdump.org/release/libpcap-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A portable framework for low-level network monitoring."
# use configure, not cmake. review cmake in future release.
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-cfg-libs"

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
