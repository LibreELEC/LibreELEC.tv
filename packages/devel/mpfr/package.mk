# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpfr"
PKG_VERSION="4.2.1"
PKG_SHA256="277807353a6726978996945af13e52829e3abd7a9a5b7fb2793894e18f1fcbb2"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mpfr.org/"
PKG_URL="https://ftpmirror.gnu.org/mpfr/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host gmp:host"
PKG_DEPENDS_TARGET="gmp"
PKG_LONGDESC="A C library for multiple-precision floating-point computations with exact rounding."

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} \
                         --enable-static --disable-shared \
                         --prefix=${TOOLCHAIN} \
                         --with-gmp-lib=${TOOLCHAIN}/lib \
                         --with-gmp-include=${TOOLCHAIN}/include"

PKG_CONFIGURE_OPTS_TARGET="--target=${TARGET_NAME} \
                         --enable-static --disable-shared"
