# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="automake"
PKG_VERSION="1.18"
PKG_SHA256="5bdccca96b007a7e344c24204b9b9ac12ecd17f5971931a9063bdee4887f4aaf"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/automake/"
PKG_URL="https://ftpmirror.gnu.org/automake/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host autoconf:host"
PKG_LONGDESC="A GNU tool for automatically creating Makefiles."
PKG_BUILD_FLAGS="-parallel -cfg-libs:host"

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} --disable-silent-rules"

post_makeinstall_host() {
  make prefix=${SYSROOT_PREFIX}/usr install
}
