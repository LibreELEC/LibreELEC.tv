# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libheif"
PKG_VERSION="1.23.7"
PKG_SHA256="f7483e818503ea6224c8863e4a56ac02c7089021a98472c811c12aa19faf2475"
PKG_LICENSE="LGPL-3.0-or-later"
PKG_SITE="https://www.libde265.org"
PKG_URL="https://github.com/strukturag/libheif/releases/download/v${PKG_VERSION}/libheif-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libde265 libjpeg-turbo libpng"
PKG_LONGDESC="A HEIF file format decoder and encoder."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DWITH_EXAMPLES=OFF \
                       -DWITH_AOM_DECODER=OFF \
                       -DWITH_AOM_ENCODER=OFF \
                       -DWITH_X264=OFF \
                       -DWITH_X265=OFF \
                       -DWITH_OpenH264_DECODER=OFF \
                       -DWITH_GDK_PIXBUF=OFF \
                       -DWITH_LIBSHARPYUV=OFF \
                       -DBUILD_TESTING=OFF"

pre_configure_target() {
  export CXXFLAGS="${CXXFLAGS} -Wno-unused-variable"
}
