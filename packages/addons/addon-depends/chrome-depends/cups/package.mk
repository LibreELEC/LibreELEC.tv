# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cups"
PKG_VERSION="2.4.12"
PKG_SHA256="7a4d32822b320aa2999b18fdfc4ce5ca9ad204fe6302ff69e6c24b21f8d0eaa0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.cups.org"
PKG_URL="https://github.com/openprinting/cups/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain gnutls zlib"
PKG_LONGDESC="CUPS printing system."
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--libdir=/usr/lib \
                           --disable-gssapi \
                           --with-dnssd=no \
                           --with-tls=gnutls
                           --disable-unit-tests"

pre_configure_target() {
  cd ..
  rm -rf .${TARGET_NAME}
}

makeinstall_target() {
  make BUILDROOT="${INSTALL}" install
}
