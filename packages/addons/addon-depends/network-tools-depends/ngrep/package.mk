# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ngrep"
PKG_VERSION="1.49.0"
PKG_SHA256="6c94b31681316b7469a3ace92d2aeec7c9f490bd6782453dff2ade0e289a3348"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jpr5/ngrep"
PKG_URL="https://github.com/jpr5/ngrep/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap pcre2"
PKG_LONGDESC="A tool like GNU grep applied to the network layer."
PKG_BUILD_FLAGS="-sysroot -parallel"

PKG_CONFIGURE_OPTS_TARGET="--with-pcap-includes=${SYSROOT_PREFIX}/usr/include \
                           --enable-ipv6 \
                           --enable-pcre2 \
                           --disable-dropprivs"

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}
