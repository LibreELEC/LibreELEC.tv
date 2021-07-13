# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xmlstarlet"
PKG_VERSION="1.6.7"
PKG_SHA256="70b73cd9555d2cdfbdd1d87bd64f44e04e95a8ad11d4507b406bbdd9d5ca1c46"
PKG_LICENSE="MIT"
PKG_SITE="https://pypi.org/project/xmlstarlet"
PKG_URL="https://github.com/dimitern/xmlstarlet/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="libxml2:host libxslt:host"
PKG_DEPENDS_TARGET="toolchain libxml2 libxslt"
PKG_LONGDESC="XMLStarlet is a command-line XML utility which allows the modification and validation of XML documents."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_HOST="  ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static-libs \
                           LIBXML_CONFIG=${TOOLCHAIN}/bin/xml2-config \
                           LIBXSLT_CONFIG=${TOOLCHAIN}/bin/xslt-config \
                           --with-libxml-include-prefix=${TOOLCHAIN}/include/libxml2 \
                           --with-libxml-libs-prefix=${TOOLCHAIN}/lib \
                           --with-libxslt-include-prefix=${TOOLCHAIN}/include \
                           --with-libxslt-libs-prefix=${TOOLCHAIN}/lib"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static-libs \
                           LIBXML_CONFIG=${SYSROOT_PREFIX}/usr/bin/xml2-config \
                           LIBXSLT_CONFIG=${SYSROOT_PREFIX}/usr/bin/xslt-config \
                           --with-libxml-include-prefix=${SYSROOT_PREFIX}/usr/include/libxml2 \
                           --with-libxml-libs-prefix=${SYSROOT_PREFIX}/usr/lib \
                           --with-libxslt-include-prefix=${SYSROOT_PREFIX}/usr/include \
                           --with-libxslt-libs-prefix=${SYSROOT_PREFIX}/usr/lib"

post_unpack() {
  ( 
    cd ${PKG_BUILD}
    mkdir .temp
    mv * .temp
    mv .temp/xmlstarlet/* .
    rm -rf .temp
  )
}

post_makeinstall_host() {
  ln -sf xml ${TOOLCHAIN}/bin/xmlstarlet
}

post_makeinstall_target() {
  ln -sf xml ${INSTALL}/usr/bin/xmlstarlet
}
