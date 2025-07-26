# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dtach"
PKG_VERSION="b027c27b2439081064d07a86883c8e0b20a183c9"
PKG_SHA256="2ec8db52ed99700cf80258b52e77461068abf24a2798cb91f9c0b2bc6e6ee8f4"
PKG_LICENSE="GPL"
PKG_SITE="http://dtach.sourceforge.net"
PKG_URL="https://github.com/crigler/dtach/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A program that emulates the detach feature of screen."
PKG_BUILD_FLAGS="-sysroot"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p dtach ${INSTALL}/usr/bin
}
