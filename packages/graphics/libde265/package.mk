# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libde265"
PKG_VERSION="1.0.16"
PKG_SHA256="b92beb6b53c346db9a8fae968d686ab706240099cdd5aff87777362d668b0de7"
PKG_LICENSE="LGPLv3"
PKG_SITE="http://www.libde265.org"
PKG_URL="https://github.com/strukturag/libde265/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Open h.265 video codec implementation."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DENABLE_SDL=OFF \
                       -DENABLE_DECODER=OFF \
                       -DENABLE_ENCODER=OFF"
