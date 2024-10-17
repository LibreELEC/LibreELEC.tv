# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="autoconf"
PKG_VERSION="2.72"
PKG_SHA256="ba885c1319578d6c94d46e9b0dceb4014caafe2490e437a0dbca3f270a223f5a"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/autoconf/"
PKG_URL="https://ftpmirror.gnu.org/autoconf/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host gettext:host"
PKG_LONGDESC="A GNU tool for automatically configuring source code."
PKG_BUILD_FLAGS="-cfg-libs:host"

PKG_CONFIGURE_OPTS_HOST="EMACS=no \
                         ac_cv_path_M4=${TOOLCHAIN}/bin/m4 \
                         ac_cv_prog_gnu_m4_gnu=no \
                         --target=${TARGET_NAME}"

post_makeinstall_host() {
  make prefix=${SYSROOT_PREFIX}/usr install
}
