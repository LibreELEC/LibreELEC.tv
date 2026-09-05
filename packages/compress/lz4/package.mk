# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lz4"
PKG_VERSION="1.10.0"
PKG_SHA256="537512904744b35e232912055ccf8ec66d768639ff3abe5788d90d792ec5f48b"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://github.com/lz4/lz4"
PKG_URL="https://github.com/lz4/lz4/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cmake:host ninja:host"
PKG_DEPENDS_TARGET="cmake:host gcc:host ninja:host"
PKG_LONGDESC="lz4 data compressor/decompressor"

configure_package() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/build/cmake/CMakeLists.txt"

  PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=1 \
                         -DLZ4_BUILD_CLI=OFF"
}
