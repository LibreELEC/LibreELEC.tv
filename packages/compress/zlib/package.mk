# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="zlib"
PKG_VERSION="1.3.1"
PKG_SHA256="9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23"
PKG_LICENSE="OSS"
PKG_SITE="http://www.zlib.net"
PKG_URL="https://zlib.net/fossils/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host cmake:host"
PKG_DEPENDS_TARGET="cmake:host gcc:host"
PKG_LONGDESC="A general purpose (ZIP) data compression library."
PKG_TOOLCHAIN="cmake-make"

PKG_CMAKE_OPTS_HOST="-DINSTALL_PKGCONFIG_DIR=${TOOLCHAIN}/lib/pkgconfig"

PKG_CMAKE_OPTS_TARGET="-DINSTALL_PKGCONFIG_DIR=/usr/lib/pkgconfig"
