# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libid3tag"
PKG_VERSION="0.16.4"
PKG_SHA256="8b6bc96016f6ab3a52b753349ed442e15181de9db1df01884f829e3d4f3d1e78"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://www.underbit.com/products/mad/"
PKG_URL="https://codeberg.org/tenacityteam/libid3tag/releases/download/${PKG_VERSION}/id3tag-${PKG_VERSION}-source.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="A library for id3 tagging."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF"
