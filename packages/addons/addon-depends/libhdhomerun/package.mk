# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libhdhomerun"
PKG_VERSION="20261107"
PKG_SHA256="a273f2267b32e8931a7b733d37a28367fa65ee5ce875036d0acd5b2948edc07d"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="http://www.silicondust.com"
PKG_URL="https://download.silicondust.com/hdhomerun/libhdhomerun_${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The library provides functionality to setup the HDHomeRun."

PKG_MAKE_OPTS_TARGET="CROSS_COMPILE=${TARGET_PREFIX}"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/include/hdhomerun
    cp *.h ${SYSROOT_PREFIX}/usr/include/hdhomerun

  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp libhdhomerun.a ${SYSROOT_PREFIX}/usr/lib
}
