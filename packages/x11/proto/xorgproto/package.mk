# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorgproto"
PKG_VERSION="ce7786ebb90f70897f8038d02ae187ab22766ab2"
PKG_SHA256="a0630df2c8add5773cea7d6f010d17ed0f7a3093782583504fafdfbaa4b98d55"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/archive/master/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="combined X.Org X11 Protocol headers"

PKG_MESON_OPTS_TARGET="-Dlegacy=false"
