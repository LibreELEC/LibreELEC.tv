# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="protobuf-c"
PKG_VERSION="1.5.2"
PKG_SHA256="e2c86271873a79c92b58fef7ebf8de1aa0df4738347a8bd5d4e65a80a16d0d24"
PKG_LICENSE="protobuf-c"
PKG_SITE="https://github.com/protobuf-c/protobuf-c"
PKG_URL="https://github.com/protobuf-c/protobuf-c/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host protobuf:host"
PKG_DEPENDS_TARGET="toolchain protobuf"
PKG_LONGDESC="Protocol Buffers implementation in C"
PKG_BUILD_FLAGS="-sysroot -cfg-libs +pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
