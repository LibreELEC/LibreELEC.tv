# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libiconv"
PKG_VERSION="1.19.1"
PKG_SHA256="9a06844846d664d7122161700c10a64480d7c7bcead3091925a785b38c91edab"
PKG_LICENSE="LGPL-2.0-or-later AND GPL-3.0-or-later"
PKG_SITE="https://savannah.gnu.org/projects/libiconv/"
PKG_URL="https://ftp.gnu.org/pub/gnu/libiconv/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool that converts from one character encoding to another through Unicode conversion."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--host=${TARGET_NAME} \
            --build=${HOST_NAME} \
            --prefix=/usr \
            --includedir=/usr/include/iconv \
            --libdir=/usr/lib/iconv \
            --sysconfdir=/etc \
            --enable-static \
            --disable-shared \
            --disable-nls \
            --disable-extra-encodings \
            --with-gnu-ld"
