# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="double-conversion"
PKG_VERSION="3.3.0"
PKG_SHA256="04ec44461850abbf33824da84978043b22554896b552c5fd11a9c5ae4b4d296e"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/google/double-conversion"
PKG_URL="https://github.com/google/double-conversion/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DBUILD_TESTING=OFF"
