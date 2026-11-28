# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnfs"
PKG_VERSION="8.0.1"
PKG_SHA256="03653086471ceddd846077151adc6fda9ebc47118010a196e27f4f2e3e5e32f0"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/sahlberg/libnfs"
PKG_URL="https://github.com/sahlberg/libnfs/archive/libnfs-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A client library for accessing NFS shares over a network."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-examples \
                           --without-libkrb5"

pre_configure_target() {
  export CFLAGS="${CFLAGS} -D_FILE_OFFSET_BITS=64"
}

post_configure_target() {
  libtool_remove_rpath libtool
}
