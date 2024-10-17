# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="strace"
PKG_VERSION="6.11"
PKG_SHA256="83262583a3529f02c3501aa8b8ac772b4cbc03dc934e98bab6e4883626e283a5"
PKG_LICENSE="BSD"
PKG_SITE="https://strace.io/"
PKG_URL="https://strace.io/files/${PKG_VERSION}/strace-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="strace is a diagnostic, debugging and instructional userspace utility"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs"

if [ "${TARGET_ARCH}" = x86_64 -o "${TARGET_ARCH}" = "aarch64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-mpers=no"
fi
