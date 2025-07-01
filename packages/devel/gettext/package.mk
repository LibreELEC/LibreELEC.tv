# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gettext"
PKG_VERSION="0.25"
PKG_SHA256="05240b29f5b0f422e5a4ef8e9b5f76d8fa059cc057693d2723cdb76f36a88ab0"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/s/gettext/"
PKG_URL="https://ftp.gnu.org/pub/gnu/gettext/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="make:host"
PKG_DEPENDS_TARGET="autotools:host make:host gcc:host"
PKG_LONGDESC="A program internationalization library and tools."
PKG_BUILD_FLAGS="+local-cc"

PKG_CONFIGURE_OPTS_HOST="--disable-static --enable-shared \
                         --disable-rpath \
                         --with-gnu-ld \
                         --disable-java \
                         --disable-curses \
                         --with-included-libxml \
                         --disable-native-java \
                         --disable-csharp \
                         --disable-modula2 \
                         --without-emacs"

PKG_CONFIGURE_OPTS_TARGET="--disable-rpath --disable-modula2"

post_configure_target() {
  libtool_remove_rpath gettext-runtime/libasprintf/libtool
  libtool_remove_rpath gettext-tools/libtool
}
