# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="iperf"
PKG_VERSION="3.19"
PKG_SHA256="da5cff29e4945b2ee05dcf9a0c67768cc000dc1b122935bce3492c4e36f6b5e9"
PKG_LICENSE="BSD"
PKG_SITE="http://software.es.net/iperf/"
PKG_URL="https://github.com/esnet/iperf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="A tool to measuring maximum TCP and UDP bandwidth performance."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared"
