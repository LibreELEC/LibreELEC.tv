# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="steamlink-icu"
PKG_VERSION="72-1"
PKG_SHA256="43cbad628d98f37a3f95f6c34579f9144ef4bde60248fa6004a4f006d7487e69"
PKG_LICENSE="Custom"
PKG_SITE="https://icu.unicode.org"
PKG_URL="https://github.com/unicode-org/icu/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain steamlink-icu:host"
PKG_LONGDESC="International Components for Unicode library."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-sysroot"

configure_package() {
  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/icu4c/source/configure"
  PKG_CONFIGURE_OPTS_TARGET="--disable-layout \
                             --disable-layoutex \
                             --enable-renaming \
                             --disable-samples \
                             --disable-tests \
                             --disable-tools \
                             --with-cross-build=${PKG_BUILD}/.${HOST_NAME}"
}
