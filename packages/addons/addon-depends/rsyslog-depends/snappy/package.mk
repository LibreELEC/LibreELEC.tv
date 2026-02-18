# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snappy"
PKG_VERSION="1.2.2"
PKG_SHA256="90f74bc1fbf78a6c56b3c4a082a05103b3a56bb17bca1a27e052ea11723292dc"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/google/snappy"
PKG_URL="https://github.com/google/snappy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fast compressor/decompressor"
PKG_BUILD_FLAGS="-sysroot +pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DSNAPPY_BUILD_BENCHMARKS=OFF \
                       -DSNAPPY_BUILD_TESTS=OFF"
