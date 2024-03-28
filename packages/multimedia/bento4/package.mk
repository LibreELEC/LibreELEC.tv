# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bento4"
PKG_VERSION="1.6.0-641-Omega"
PKG_SHA256="f1f8cfa4f7cb651b609e587f825607cb4b06fe5b08af876fd0154a434f9a5315"
PKG_LICENSE="GPL"
PKG_SITE="https://www.bento4.com"
PKG_URL="https://github.com/xbmc/Bento4/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_UNPACK="inputstream.adaptive"
PKG_LONGDESC="C++ class library and tools designed to read and write ISO-MP4 files"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_APPS=OFF"
