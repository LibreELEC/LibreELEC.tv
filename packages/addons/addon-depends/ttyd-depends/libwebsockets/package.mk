# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libwebsockets"
PKG_VERSION="5.1.0"
PKG_SHA256="9acbba00aaa9e6178ae09c6f920d95449b527c1417e81d2cdd4103bc6d64d13f"
PKG_LICENSE="MIT"
PKG_SITE="https://libwebsockets.org"
PKG_URL="https://github.com/warmcat/libwebsockets/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl json-c libuv"
PKG_LONGDESC="Library for implementing network protocols with a tiny footprint."

PKG_CMAKE_OPTS_TARGET="-DLWS_WITH_HTTP3=OFF \
                       -DLWS_WITH_LIBUV=ON \
                       -DLWS_WITHOUT_TESTAPPS=ON"
