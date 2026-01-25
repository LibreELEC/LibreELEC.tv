# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gettext"
PKG_VERSION="1.0-pre2"
PKG_SHA256="c2ea47b7d8d873a19e138b5d89cc052aea49171a8e5f2714f7fbd5b80e7069b8"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/s/gettext/"
PKG_URL="https://ftp.gnu.org/pub/gnu/gettext/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_URL="https://alpha.gnu.org/gnu/gettext/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="make:host"
PKG_DEPENDS_TARGET="autotools:host make:host gcc:host"
PKG_LONGDESC="A program internationalization library and tools."
PKG_BUILD_FLAGS="+local-cc"

PKG_CONFIGURE_OPTS_COMMON="--disable-rpath \
                           --disable-modula2"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_COMMON} \
                         --disable-static --enable-shared \
                         --with-gnu-ld \
                         --disable-java \
                         --disable-curses \
                         --with-included-libxml \
                         --disable-native-java \
                         --disable-csharp \
                         --without-emacs"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_COMMON} \
                           --with-sysroot=yes"

post_configure_target() {
  libtool_remove_rpath gettext-runtime/libasprintf/libtool
  libtool_remove_rpath gettext-tools/libtool
}
