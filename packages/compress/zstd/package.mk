# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zstd"
PKG_VERSION="1.6.0"
PKG_SHA256="2ca30d45c7a61f255e17024373f7fe75b6403b2ade6b21220c1472964d8a466a"
PKG_LICENSE="GPL-2.0-only OR BSD-3-Clause"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.zst"
PKG_DEPENDS_HOST="cmake:host make:host"
PKG_DEPENDS_TARGET="cmake:host gcc:host"
PKG_LONGDESC="A fast real-time compression algorithm."
# Override toolchain as meson and ninja are not built yet
# and zstd is a dependency of ccache
PKG_TOOLCHAIN="cmake-make"
PKG_BUILD_FLAGS="+local-cc"

configure_package() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/build/cmake/CMakeLists.txt"
}

configure_host() {
  # custom cmake build to override the LOCAL_CC/CXX
  cp ${CMAKE_CONF} cmake-zstd.conf

  echo "SET(CMAKE_C_COMPILER   ${CC})"  >>cmake-zstd.conf
  echo "SET(CMAKE_CXX_COMPILER ${CXX})" >>cmake-zstd.conf

  cmake -DCMAKE_TOOLCHAIN_FILE=cmake-zstd.conf \
        -DCMAKE_INSTALL_PREFIX=${TOOLCHAIN} \
        -DZSTD_LEGACY_SUPPORT=0 \
        -DZSTD_BUILD_PROGRAMS=OFF \
        -DZSTD_BUILD_TESTS=OFF \
        ${PKG_CMAKE_SCRIPT%/*}
}

PKG_CMAKE_OPTS_TARGET="-DZSTD_LEGACY_SUPPORT=0 \
                       -DBUILD_SHARED_LIBS=ON \
                       -DZSTD_BUILD_STATIC=OFF \
                       -DZSTD_BUILD_PROGRAMS=OFF \
                       -DZSTD_BUILD_TESTS=OFF"
