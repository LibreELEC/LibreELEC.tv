# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xcb-proto"
PKG_VERSION="1.17.0"
PKG_SHA256="2c1bacd2110f4799f74de6ebb714b94cf6f80fb112316b1219480fd22562148c"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/proto/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros Python3:host"
PKG_LONGDESC="X C-language Bindings protocol headers."
PKG_BUILD_FLAGS="-cfg-libs"

post_makeinstall_target() {
  python_remove_source
}
