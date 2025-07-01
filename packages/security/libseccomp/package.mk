# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libseccomp"
PKG_VERSION="2.6.0"
PKG_SHA256="83b6085232d1588c379dc9b9cae47bb37407cf262e6e74993c61ba72d2a784dc"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://github.com/seccomp/libseccomp"
PKG_URL="https://github.com/seccomp/libseccomp/releases/download/v${PKG_VERSION}/libseccomp-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An easy to use, platform independent, interface to the Linux Kernel syscall filtering mechanism"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET+=" --enable-static --enable-shared"
