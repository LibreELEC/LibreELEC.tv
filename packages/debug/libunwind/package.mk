# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libunwind"
PKG_VERSION="1.8.3"
PKG_SHA256="4dcbdba4e25544d3753dbbcd5cc4cd36d3eb6e6d2f23d8ab61c0ee1ca6da54e3"
PKG_LICENSE="MIT"
PKG_SITE="https://www.nongnu.org/libunwind/"
PKG_URL="https://github.com/libunwind/libunwind/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="autotools:host gcc:host zlib"
PKG_LONGDESC="library to determine the call-chain of a program"
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-minidebuginfo \
                           --disable-documentation \
                           --disable-tests"

makeinstall_target() {
  make DESTDIR=${SYSROOT_PREFIX} install
}
