# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxmlb"
PKG_VERSION="0.3.29"
PKG_SHA256="b5efb78fc8033672826532e0e81e159dd3b01be7e8c3616e2dfefefc66d28ed6"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/hughsie/libxmlb"
PKG_URL="https://github.com/hughsie/libxmlb/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host glib:host"
PKG_DEPENDS_TARGET="toolchain glib Python3 xz zstd"
PKG_LONGDESC="A library to help create and query binary XML blobs"
PKG_BUILD_FLAGS="+pic:host +pic -sysroot"

PKG_MESON_OPTS_HOST="-Ddefault_library=static \
                     -Dgtkdoc=false \
                     -Dintrospection=false \
                     -Dtests=false \
                     -Dstemmer=false \
                     -Dlzma=disabled \
                     -Dzstd=disabled"

PKG_MESON_OPTS_TARGET="-Ddefault_library=static \
                       -Dgtkdoc=false \
                       -Dintrospection=false \
                       -Dtests=false \
                       -Dstemmer=false \
                       -Dlzma=enabled \
                       -Dzstd=enabled"
