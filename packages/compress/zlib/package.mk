# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zlib"
PKG_VERSION="1.4"
PKG_SHA256="02dd159783677a749c04adbdd02b55b8a2bcc7e054f51b76b549199a916ad584"
PKG_LICENSE="Zlib"
PKG_SITE="http://www.zlib.net"
PKG_URL="https://zlib.net/fossils/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host cmake:host"
PKG_DEPENDS_TARGET="cmake:host gcc:host"
PKG_LONGDESC="A general purpose (ZIP) data compression library."
PKG_TOOLCHAIN="cmake-make"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_HOST="-DINSTALL_PKGCONFIG_DIR=${TOOLCHAIN}/lib/pkgconfig"

PKG_CMAKE_OPTS_TARGET="-DINSTALL_PKGCONFIG_DIR=/usr/lib/pkgconfig"
