# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ngrep"
PKG_VERSION="b2e3ba3c5a593abf203e65a407c3a9de0f998d4a"
PKG_SHA256="daeb3e0473120541ebfa0d16b9cf4829d797d04cf30348d6c02b9b9a37fc9f05"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jpr5/ngrep"
PKG_URL="https://github.com/jpr5/ngrep/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap pcre2"
PKG_LONGDESC="A tool like GNU grep applied to the network layer."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -parallel"

PKG_CONFIGURE_OPTS_TARGET="--with-pcap-includes=${SYSROOT_PREFIX}/usr/include \
                           --enable-ipv6 \
                           --enable-pcre2 \
                           --disable-dropprivs"

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}
