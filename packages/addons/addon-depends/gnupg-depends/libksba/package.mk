# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libksba"
PKG_VERSION="1.9.1"
PKG_SHA256="9afdd398b4a076735e1e7fd29c7f6e7670b6c382aee2d3a55aa937b283f43e5b"
PKG_LICENSE="GPL-2.0-or-later OR LGPL-3.0-or-later"
PKG_SITE="https://www.gnupg.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libksba/libksba-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error"
PKG_LONGDESC="A library to work with X.509 certificates"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --with-libgpg-error-prefix=${SYSROOT_PREFIX}/usr"
