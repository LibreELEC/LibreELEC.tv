# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="newt"
PKG_VERSION="0.52.24"
PKG_SHA256="5ded7e221f85f642521c49b1826c8de19845aa372baf5d630a51774b544fbdbb"
PKG_LICENSE="GPL"
PKG_SITE="https://pagure.io/newt"
PKG_URL="https://releases.pagure.org/newt/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain slang popt"
PKG_LONGDESC="Newt is a programming library for color text mode, widget based user interfaces."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-python \
                           --without-tcl"

pre_configure_target() {
  # newt fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

pre_configure_host() {
  # newt fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${HOST_NAME}
}
