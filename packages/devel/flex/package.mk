# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flex"
PKG_VERSION="2.6.11"
PKG_SHA256="188e9c96b8fc032b2a0bdd24d4f0b692480c1854511c2fcc3034946f14fdf49a"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/westes/flex"
PKG_URL="https://github.com/westes/flex/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host m4:host autotools:host bison:host"
PKG_DEPENDS_TARGET="toolchain flex:host"
PKG_LONGDESC="A tool for generating programs that perform pattern-matching on text."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared --disable-rpath --with-gnu-ld"

PKG_CONFIGURE_OPTS_TARGET="--disable-bootstrap \
                           ac_cv_func_realloc_0_nonnull=yes \
                           ac_cv_func_malloc_0_nonnull=yes"

post_makeinstall_host() {
  cat >${TOOLCHAIN}/bin/lex  <<"EOF"
#!/bin/sh
exec flex "$@"
EOF

  chmod -v 755 ${TOOLCHAIN}/bin/lex
}
