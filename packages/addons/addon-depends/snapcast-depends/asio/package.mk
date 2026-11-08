# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="asio"
PKG_VERSION="1.39.0"
PKG_SHA256="06ca7f46149eba3411a64e735e88afa206bd4f413ea9809ef0a24e0d511cff9b"
PKG_LICENSE="BSL-1.0"
PKG_SITE="http://think-async.com/Asio"
PKG_URL="https://github.com/chriskohlhoff/asio/archive/asio-${PKG_VERSION//./-}.zip"
PKG_SOURCE_DIR="asio-asio-${PKG_VERSION//./-}"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Asio C++ Library."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--without-boost --without-openssl"
