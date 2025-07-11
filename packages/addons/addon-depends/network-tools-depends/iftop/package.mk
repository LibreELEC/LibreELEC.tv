# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="iftop"
PKG_VERSION="75d1818129cbb8ff1bb7ca4915b95046f3ed0666"
PKG_SHA256="a4b507ba5ad1ec3e41263bee38f202267644adc05d150322f0d8f85c3e2d3f43"
PKG_LICENSE="GPL"
PKG_SITE="http://www.ex-parrot.com/pdw/iftop/"
PKG_URL="https://code.blinkace.com/pdw/iftop/-/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses libpcap libnl"
PKG_LONGDESC="A tool to display bandwidth usage on an interface."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}

pre_configure_target() {
  export LIBS="-lpcap -lnl-3 -lnl-genl-3 -lncurses"
}
