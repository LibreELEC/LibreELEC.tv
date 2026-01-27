# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hddtemp"
PKG_VERSION="0.4.4"
PKG_SHA256="e4a60223fdec5adcbf4cf6d2fe5c4a5c2eef256c7b89f8deab0e921a1f631daa"
PKG_LICENSE="GPL"
PKG_SITE="https://savannah.nongnu.org/projects/hddtemp"
PKG_URL="https://github.com/vitlav/hddtemp/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A utility that gives you the temperature of your hard drive by reading S.M.A.R.T.."
PKG_BUILD_FLAGS="-sysroot"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-db-path=/storage/.kodi/addons/virtual.system-tools/data/hddtemp.db"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/misc
  cp ${PKG_DIR}/db/* ${INSTALL}/usr/share/misc
}
