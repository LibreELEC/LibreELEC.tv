# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libtatsu"
PKG_VERSION="1.1.1"
PKG_SHA256="18f471f131c1d55ccc02fa09565d870030c6ce92f737b89fe1b3849941ebb303"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="https://github.com/libimobiledevice/libtatsu/releases/download/${PKG_VERSION}/libtatsu-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain curl libplist"
PKG_LONGDESC="Library handling the communication with Apple Tatsu Signing Server (TSS)"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-largefile"
