# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libtasn1"
PKG_VERSION="4.21.0"
PKG_SHA256="1d8a444a223cc5464240777346e125de51d8e6abf0b8bac742ac84609167dc87"
PKG_LICENSE="LGPL-2.1-or-later AND GPL-3.0-or-later"
PKG_SITE="https://www.gnu.org/software/libtasn1/"
PKG_URL="https://ftp.gnu.org/gnu/libtasn1/libtasn1-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host"
PKG_LONGDESC="A library for Abstract Syntax Notation One (ASN.1) and DER manipulation."
PKG_BUILD_FLAGS="+pic +pic:host"

PKG_CONFIGURE_OPTS_COMMON="--disable-doc \
                           --disable-shared \
                           --enable-static \
                           --disable-valgrind-tests"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_COMMON}"
PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_COMMON}"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin
}
