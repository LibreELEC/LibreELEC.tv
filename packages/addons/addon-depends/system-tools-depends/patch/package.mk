# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="patch"
PKG_VERSION="2.8.1"
PKG_SHA256="3240c7959c5347c8ed347e3c4201c0337bf4240d5cf09d68889e58eeaba30e17"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://savannah.gnu.org/projects/patch"
PKG_URL="https://ftpmirror.gnu.org/patch/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Patch takes a patch file containing a difference listing produced by the diff."
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--disable-xattr"
