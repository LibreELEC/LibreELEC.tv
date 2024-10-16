# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libssh2"
PKG_VERSION="1.11.1"
PKG_SHA256="d9ec76cbe34db98eec3539fe2c899d26b0c837cb3eb466a56b0f109cabf658f7"
PKG_LICENSE="BSD"
PKG_SITE="https://www.libssh2.org"
PKG_URL="https://www.libssh2.org/download/libssh2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="A library implementing the SSH2 protocol"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLES=OFF \
                       -DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_TESTING=OFF"
