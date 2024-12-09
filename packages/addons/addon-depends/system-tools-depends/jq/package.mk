# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jq"
PKG_VERSION="8bcdc9304ace5f2cc9bf662ab8998d75537e05f0"
PKG_SHA256="f5bca864d0d9c28c330a93a790e19d0cd2a4fc58cfa94179d38e2492a3f03fd0"
PKG_LICENSE="MIT"
PKG_SITE="https://jqlang.github.io/jq/"
PKG_URL="https://github.com/jqlang/jq/releases/download/${PKG_NAME}-${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_URL="https://github.com/jqlang/jq/archive/refs/heads/master.tar.gz"
PKG_DEPENDS_TARGET="toolchain oniguruma"
PKG_LONGDESC="Command-line JSON processor"
PKG_BUILD_FLAGS="-sysroot"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-docs \
                           --disable-maintainer-mode \
                           --disable-valgrind"
