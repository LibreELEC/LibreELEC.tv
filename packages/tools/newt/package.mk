# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="newt"
PKG_VERSION="0.52.25"
PKG_SHA256="ef0ca9ee27850d1a5c863bb7ff9aa08096c9ed312ece9087b30f3a426828de82"
PKG_LICENSE="LGPL-2.0-only"
PKG_SITE="https://gitlab.com/newt-ui/newt"
PKG_URL="https://gitlab.com/newt-ui/newt/-/releases/${PKG_VERSION}/downloads/newt-${PKG_VERSION}.tar.gz"
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
