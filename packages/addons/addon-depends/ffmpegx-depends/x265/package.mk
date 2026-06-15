# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x265"
PKG_VERSION="4.2"
PKG_SHA256="04978f795943e49fcea76eb5ede9c1bd0fe9b6c073518897be6fc43b44f60850"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://www.videolan.org/developers/x265.html"
PKG_URL="https://bitbucket.org/multicoreware/x265_git/get/${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="x265 is a H.265/HEVC video encoder application library"
PKG_TOOLCHAIN="make"

pre_configure_target() {
  LDFLAGS+=" -ldl"
  ${CMAKE} -G "Unix Makefiles" ./source
}
