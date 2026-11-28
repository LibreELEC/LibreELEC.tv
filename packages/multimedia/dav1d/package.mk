# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="1.5.5"
PKG_SHA256="ca96b1d0ba3f01f55de7231d775892b64994ba061aaeeaaa4f662a390b3abf9e"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://www.videolan.org/projects/dav1d.html"
PKG_URL="https://downloads.videolan.org/pub/videolan/dav1d/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Denable_examples=false \
                       -Denable_tests=false \
                       -Denable_tools=false \
                       -Dtestdata_tests=false"
