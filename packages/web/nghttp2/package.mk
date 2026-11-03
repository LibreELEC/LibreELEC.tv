# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nghttp2"
PKG_VERSION="1.71.0"
PKG_SHA256="c0f55121d88650e4b9227aec28cebaf664d2417ca60fe70be0f8d38829f52116"
PKG_LICENSE="MIT"
PKG_SITE="http://www.linuxfromscratch.org/blfs/view/cvs/basicnet/nghttp2.html"
PKG_URL="https://github.com/nghttp2/nghttp2/releases/download/v${PKG_VERSION}/nghttp2-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="nghttp2 is an implementation of HTTP/2 and its header compression algorithm, HPACK."

PKG_CMAKE_OPTS_TARGET="-DENABLE_DOC=OFF \
                       -DENABLE_FAILMALLOC=OFF \
                       -DENABLE_LIB_ONLY=ON \
                       -DBUILD_SHARED_LIBS=ON \
                       -DBUILD_STATIC_LIBS=OFF"

post_makeinstall_target() {
  rm -r "${INSTALL}/usr/share"
}
