# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libplist"
PKG_VERSION="2.8.1"
PKG_SHA256="2a1792e5820e1657c173735fde75baeebd6dd967d2ac47be1e3891ddc64ebefa"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="http://www.libimobiledevice.org/"
PKG_URL="https://github.com/libimobiledevice/libplist/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain glib"
PKG_LONGDESC="libplist is a library for manipulating Apple Binary and XML Property Lists"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--without-cython"

pre_configure_target() {
  # work around bashism in configure script
  export CONFIG_SHELL="/bin/bash"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
