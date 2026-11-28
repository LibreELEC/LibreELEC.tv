# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="expat"
PKG_VERSION="2.11.0"
PKG_SHA256="61e7614b602201c28a189dafee78f5bceaee192bbde46a930752ff09cf5542fa"
PKG_LICENSE="MIT"
PKG_SITE="https://libexpat.github.io"
PKG_URL="https://github.com/libexpat/libexpat/releases/download/R_${PKG_VERSION//./_}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="cmake:host ninja:host"
PKG_DEPENDS_TARGET="cmake:host ninja:host gcc:host"
PKG_LONGDESC="Expat is an XML parser library written in C."

PKG_CMAKE_OPTS_TARGET="-DEXPAT_BUILD_DOCS=OFF \
                       -DEXPAT_BUILD_TOOLS=OFF \
                       -DEXPAT_BUILD_EXAMPLES=OFF \
                       -DEXPAT_BUILD_TESTS=OFF \
                       -DEXPAT_SHARED_LIBS=ON"

PKG_CMAKE_OPTS_HOST="-DEXPAT_BUILD_DOCS=OFF \
                     -DEXPAT_BUILD_TOOLS=OFF \
                     -DEXPAT_BUILD_EXAMPLES=OFF \
                     -DEXPAT_BUILD_TESTS=OFF \
                     -DEXPAT_SHARED_LIBS=ON"
