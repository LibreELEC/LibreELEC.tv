# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libraw"
PKG_VERSION="0.21.5"
PKG_SHA256="20ecfa6aad943d383ab3f66d303727ef542b042cbba2bb7ddaeff0bb2e9ff916"
PKG_LICENSE="LGPL"
PKG_SITE="https://www.libraw.org/"
PKG_URL="https://www.libraw.org/data/LibRaw-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo lcms2"
PKG_LONGDESC="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-openmp \
                           --enable-jpeg \
                           --disable-jasper \
                           --enable-lcms \
                           --disable-examples"
