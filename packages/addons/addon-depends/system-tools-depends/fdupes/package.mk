# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fdupes"
PKG_VERSION="2.4.0"
PKG_SHA256="527b27a39d031dcbe1d29a220b3423228c28366c2412887eb72c25473d7b1736"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/adrianlopezroche/fdupes"
PKG_URL="https://github.com/adrianlopezroche/fdupes/releases/download/v${PKG_VERSION}/fdupes-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses sqlite"
PKG_LONGDESC="A program for identifying or deleting duplicate files residing within specified directories."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--without-ncurses"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_MAKEINSTALL_OPTS_TARGET="${PKG_MAKE_OPTS_TARGET}"
