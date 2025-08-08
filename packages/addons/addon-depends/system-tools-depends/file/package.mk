# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="file"
PKG_VERSION="5.46"
PKG_SHA256="c9cc77c7c560c543135edc555af609d5619dbef011997e988ce40a3d75d86088"
PKG_LICENSE="BSD"
PKG_SITE="https://www.darwinsys.com/file/"
PKG_URL="http://ftp.astron.com/pub/file/file-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain file:host zlib"
PKG_LONGDESC="The file utility is used to determine the types of various files."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_HOST="--enable-fsect-man5 \
                         --enable-static \
                         --disable-shared"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_HOST}"
