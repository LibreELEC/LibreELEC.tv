# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="md4c"
PKG_VERSION="0.5.2"
PKG_SHA256="55d0111d48fb11883aaee91465e642b8b640775a4d6993c2d0e7a8092758ef21"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/mity/md4c"
PKG_URL="https://github.com/mity/md4c/archive/refs/tags/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="C Markdown parser. Fast. SAX-like interface. Compliant to CommonMark specification."
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DBUILD_MD2HTML_EXECUTABLE=OFF \
                       -DBUILD_SHARED_LIBS=ON"
