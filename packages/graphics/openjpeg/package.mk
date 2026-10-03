# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openjpeg"
PKG_VERSION="2.5.4"
PKG_SHA256="a695fbe19c0165f295a8531b1e4e855cd94d0875d2f88ec4b61080677e27188a"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://www.openjpeg.org"
PKG_URL="https://github.com/uclouvain/openjpeg/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A JPEG 2000 codec, used by Poppler for the scanned pages of game manuals."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_CODEC=OFF \
                       -DBUILD_TESTING=OFF"
