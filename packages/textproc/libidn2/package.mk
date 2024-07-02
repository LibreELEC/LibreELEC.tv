# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libidn2"
PKG_VERSION="2.3.7"
PKG_SHA256="4c21a791b610b9519b9d0e12b8097bf2f359b12f8dd92647611a929e6bfd7d64"
PKG_LICENSE="LGPL3"
PKG_SITE="https://www.gnu.org/software/libidn/"
PKG_URL="https://ftpmirror.gnu.org/gnu/libidn/libidn2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autoconf:host gcc:host"
PKG_DEPENDS_TARGET="autoconf:host gcc:host"
PKG_LONGDESC="Free software implementation of IDNA2008, Punycode and TR46."

PKG_CONFIGURE_OPTS_COMMON="--disable-doc \
                           --enable-shared \
                           --disable-static"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_COMMON}"
PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_COMMON}"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin
}
