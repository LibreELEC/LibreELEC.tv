# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nasm"
PKG_VERSION="2.16.03"
PKG_SHA256="1412a1c760bbd05db026b6c0d1657affd6631cd0a63cddb6f73cc6d4aa616148"
PKG_ARCH="x86_64"
PKG_LICENSE="BSD"
PKG_SITE="https://www.nasm.us/"
PKG_URL="https://www.nasm.us/pub/nasm/releasebuilds/${PKG_VERSION}/nasm-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The Netwide Assembler, NASM, is an 80x86 and x86-64 assembler designed for portability and modularity."
PKG_BUILD_FLAGS="-cfg-libs:host"
