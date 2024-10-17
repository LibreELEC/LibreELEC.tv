# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screen"
PKG_VERSION="5.0.0"
PKG_SHA256="f04a39d00a0e5c7c86a55338808903082ad5df4d73df1a2fd3425976aed94971"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/screen/"
PKG_URL="https://ftpmirror.gnu.org/screen/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Screen is a window manager that multiplexes a physical terminal between several processes"
PKG_BUILD_FLAGS="-sysroot -parallel -cfg-libs"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_utempter_h=no \
                           --disable-pam \
                           --disable-telnet \
                           --disable-socket-dir"
