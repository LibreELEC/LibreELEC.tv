# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screen"
PKG_VERSION="5.0.1"
PKG_SHA256="2dae36f4db379ffcd14b691596ba6ec18ac3a9e22bc47ac239789ab58409869d"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/screen/"
PKG_URL="https://ftpmirror.gnu.org/screen/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Screen is a window manager that multiplexes a physical terminal between several processes"
PKG_BUILD_FLAGS="-sysroot -parallel"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_utempter_h=no \
                           --disable-pam \
                           --disable-telnet \
                           --disable-socket-dir"
