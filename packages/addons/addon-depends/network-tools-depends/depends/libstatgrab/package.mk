# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libstatgrab"
PKG_VERSION="0.92.2"
PKG_SHA256="ff559fcd4da75a4023af986c02c52ad51d4b68ae83fc0c8c461026126a8ebefa"
PKG_SITE="https://libstatgrab.org"
PKG_URL="https://github.com/libstatgrab/libstatgrab/releases/download/LIBSTATGRAB_${PKG_VERSION//./_}/libstatgrab-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION=libs
PKG_LONGDESC="A library that provides cross platform access to statistics about the system on which it's run."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           --enable-static \
                           --disable-shared \
                           --disable-saidar \
                           --disable-examples \
                           --disable-setuid-binaries \
                           --disable-setgid-binaries"
