# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="st"
PKG_VERSION="0.9.2"
PKG_SHA256="6b215d4f472b21d6232f30f221117a777e24bcfee68955ddefb7426467f9494b"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://st.suckless.org/"
PKG_URL="https://dl.suckless.org/st/st-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libXft libXrender fontconfig freetype ncurses"
PKG_LONGDESC="A simple terminal implementation for X"
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_TARGET="X11INC=$(get_install_dir libXft)/usr/include \
                      X11LIB=$(get_install_dir libXft)/usr/lib"

pre_configure_target() {
  LDFLAGS="-lXrender ${LDFLAGS}"
}
