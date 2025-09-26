# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libfmt"
PKG_VERSION="12.0.0"
PKG_SHA256="aa3e8fbb6a0066c03454434add1f1fc23299e85758ceec0d7d2d974431481e40"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/fmtlib/fmt"
PKG_URL="https://github.com/fmtlib/fmt/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cmake:host make:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="fmt is an open-source formatting library for C++. It can be used as a safe alternative to printf or as a fast alternative to IOStreams."
PKG_TOOLCHAIN="cmake-make"
PKG_BUILD_FLAGS="+local-cc +lto"

PKG_CMAKE_OPTS_COMMON="-DCMAKE_CXX_STANDARD=14 \
                       -DCMAKE_CXX_EXTENSIONS:BOOL=OFF \
                       -DFMT_DOC=OFF \
                       -DFMT_INSTALL=ON \
                       -DFMT_TEST=OFF \
                       -DBUILD_SHARED_LIBS=ON"

PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_COMMON}"

configure_host() {
  # custom cmake build to override the LOCAL_CC/CXX
  cp ${CMAKE_CONF} cmake-ccache.conf

  echo "SET(CMAKE_C_COMPILER   ${CC})"  >>cmake-ccache.conf
  echo "SET(CMAKE_CXX_COMPILER ${CXX})" >>cmake-ccache.conf
  cmake -DCMAKE_TOOLCHAIN_FILE=cmake-ccache.conf \
        -DCMAKE_INSTALL_PREFIX=${TOOLCHAIN} \
        ${PKG_CMAKE_OPTS_COMMON} \
        ..
}
