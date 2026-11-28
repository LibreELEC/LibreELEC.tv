# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmicrohttpd"
PKG_VERSION="1.0.11"
PKG_SHA256="f227a044b75688e449b58ddedf0582255cc562899ff69f173a8ef76439744b4e"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://www.gnu.org/software/libmicrohttpd/"
PKG_URL="https://ftpmirror.gnu.org/libmicrohttpd/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain gnutls"
PKG_LONGDESC="A small C library that is supposed to make it easy to run an HTTP server as part of another application."

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
                           --disable-static \
                           --disable-examples \
                           --disable-curl \
                           --enable-https"

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
