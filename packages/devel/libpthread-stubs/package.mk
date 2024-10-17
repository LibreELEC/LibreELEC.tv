# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libpthread-stubs"
PKG_VERSION="0.5"
PKG_SHA256="593196cc746173d1e25cb54a93a87fd749952df68699aab7e02c085530e87747"
PKG_LICENSE="OSS"
PKG_SITE="http://xcb.freedesktop.org/"
PKG_URL="http://xcb.freedesktop.org/dist/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A library providing weak aliases for pthread functions."
PKG_BUILD_FLAGS="-cfg-libs"
