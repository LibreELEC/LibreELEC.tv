# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="opusfile"
PKG_VERSION="0.12"
PKG_SHA256="118d8601c12dd6a44f52423e68ca9083cc9f2bfe72da7a8c1acb22a80ae3550b"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://opus-codec.org"
PKG_URL="https://ftp.osuosl.org/pub/xiph/releases/opus/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libogg opus"
PKG_LONGDESC="Library for decoding and seeking in .opus files."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-http \
                           --disable-examples \
                           --disable-doc"
