# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libconfig"
PKG_VERSION="1.8.1"
PKG_SHA256="e95798d2992a66ecd547ce3651d7e10642ff2211427c43a7238186ff4c372627"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/hyperrealm/libconfig"
PKG_URL="https://github.com/hyperrealm/libconfig/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C/C++ configuration file library."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-doc \
                           --disable-examples \
                           --disable-tests \
                           --with-sysroot=${SYSROOT_PREFIX}"

pre_configure_target() {
  cd ..
  rm -rf .${TARGET_NAME}
}
