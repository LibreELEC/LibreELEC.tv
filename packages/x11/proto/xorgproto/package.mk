# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorgproto"
PKG_VERSION="2024.1"
PKG_SHA256="372225fd40815b8423547f5d890c5debc72e88b91088fbfb13158c20495ccb59"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/proto/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="combined X.Org X11 Protocol headers"

PKG_MESON_OPTS_TARGET="-Dlegacy=false"
