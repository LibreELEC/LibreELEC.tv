# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="patch"
PKG_VERSION="2.8"
PKG_SHA256="f87cee69eec2b4fcbf60a396b030ad6aa3415f192aa5f7ee84cad5e11f7f5ae3"
PKG_LICENSE="GPL"
PKG_SITE="https://savannah.gnu.org/projects/patch"
PKG_URL="https://ftpmirror.gnu.org/patch/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Patch takes a patch file containing a difference listing produced by the diff."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-xattr"
