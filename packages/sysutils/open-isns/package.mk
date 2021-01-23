# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="open-isns"
PKG_VERSION="0.100"
PKG_SHA256="b011edbb0f31690aaca902a8ecf4e1f17b01d6c9e9afc51909d26b0993b4328f"
PKG_LICENSE="LGPL2.1"
PKG_SITE="https://github.com/open-iscsi/open-isns"
PKG_URL="https://github.com/open-iscsi/open-isns/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="iSNS server and client for Linux"

makeinstall_target() {
  :
}

post_makeinstall_target() {
  export DESTDIR="${SYSROOT_PREFIX}"
  make install_hdrs
  make install_lib
}
