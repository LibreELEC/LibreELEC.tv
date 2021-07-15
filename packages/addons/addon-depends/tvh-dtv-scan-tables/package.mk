# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tvh-dtv-scan-tables"
PKG_VERSION="a97c9d49fa2d3e572a39c254ca5a1485ce69f376" # 2020-12-26
PKG_SHA256="9845f0dbd1bc0c7d39bf63db684b41a0a7759a8b8ac96af1cbd0b24c4b0bb68d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tvheadend"
PKG_URL="https://github.com/crazycat69/dtv-scan-tables/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Digital TV scan tables"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

makeinstall_target() {
  make install DATADIR=${INSTALL}/usr/share
}
