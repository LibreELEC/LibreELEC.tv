# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libusbmuxd"
PKG_VERSION="2.1.1"
PKG_SHA256="bcc185615a0f4ba80b617696235a084c64b68a1bf546a1dedd85da6b62b8cfbe"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="https://github.com/libimobiledevice/libusbmuxd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libimobiledevice-glue libplist"
PKG_LONGDESC="A USB multiplex daemon."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static \
                           --disable-shared"

configure_package() {
  # if using a git hash as a package version - set RELEASE_VERSION
  if [ -f ${PKG_BUILD}/NEWS ]; then
    export RELEASE_VERSION="$(sed -n '1,/RE/s/Version \(.*\)/\1/p' ${PKG_BUILD}/NEWS)-git-${PKG_VERSION:0:7}"
  fi
}

post_configure_target() {
  libtool_remove_rpath libtool
}
