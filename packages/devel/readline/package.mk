# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="readline"
PKG_VERSION="8.3-alpha"
PKG_SHA256="2e30f1de3c97381e53bd202715322518a6cd51938beca572fb7be0a0f2518b73"
PKG_LICENSE="MIT"
PKG_SITE="http://www.gnu.org/software/readline/"
PKG_URL="https://ftpmirror.gnu.org/readline/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="autotools:host gcc:host ncurses"
PKG_LONGDESC="The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="bash_cv_wcwidth_broken=no \
                           --disable-shared \
                           --enable-static \
                           --with-curses"

post_makeinstall_target() {
  # fix static library
  sed -i 's/-lreadline/-lreadline -lncursesw/' ${SYSROOT_PREFIX}/usr/lib/pkgconfig/readline.pc

  rm -rf ${INSTALL}/usr/share/readline
}
