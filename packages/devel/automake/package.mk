# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="automake"
PKG_VERSION="1.17"
PKG_SHA256="8920c1fc411e13b90bf704ef9db6f29d540e76d232cb3b2c9f4dc4cc599bd990"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/automake/"
PKG_URL="http://ftpmirror.gnu.org/automake/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host autoconf:host"
PKG_LONGDESC="A GNU tool for automatically creating Makefiles."
PKG_BUILD_FLAGS="-parallel -cfg-libs:host"

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} --disable-silent-rules"

post_makeinstall_host() {
  make prefix=${SYSROOT_PREFIX}/usr install
}
