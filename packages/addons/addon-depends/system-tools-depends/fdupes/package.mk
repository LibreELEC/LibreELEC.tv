# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fdupes"
PKG_VERSION="2.3.2"
PKG_SHA256="808d8decbe7fa41cab407ae4b7c14bfc27b8cb62227540c3dcb6caf980592ac7"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/adrianlopezroche/fdupes"
PKG_URL="https://github.com/adrianlopezroche/fdupes/releases/download/v${PKG_VERSION}/fdupes-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses sqlite"
PKG_LONGDESC="A program for identifying or deleting duplicate files residing within specified directories."
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--without-ncurses"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_MAKEINSTALL_OPTS_TARGET="${PKG_MAKE_OPTS_TARGET}"
