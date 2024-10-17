# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="asio"
PKG_VERSION="1.28.1"
PKG_SHA256="8c6adab3a94690773668ded084d3b0dc01d7231ec1edf1ad862f8db0e275ee56"
PKG_LICENSE="BSL"
PKG_SITE="http://think-async.com/Asio"
PKG_URL="https://github.com/chriskohlhoff/asio/archive/asio-${PKG_VERSION//./-}.zip"
PKG_SOURCE_DIR="asio-asio-${PKG_VERSION//./-}"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Asio C++ Library."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--without-boost --without-openssl"

configure_package() {
  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/asio/configure"
}
