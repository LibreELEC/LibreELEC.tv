# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fcft"
PKG_VERSION="3.3.3"
PKG_SHA256="bb298772d625e7d917373d541456f34f1957a9e22b16f17f64158b2c3816563c"
PKG_LICENSE="MIT"
PKG_SITE="https://codeberg.org/dnkl/fcft"
PKG_URL="https://codeberg.org/dnkl/fcft/releases/download/${PKG_VERSION}/fcft-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain pixman fontconfig freetype tllist"
PKG_LONGDESC="A simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman."

PKG_MESON_OPTS_TARGET="-Ddocs=disabled \
                       -Dgrapheme-shaping=disabled \
                       -Drun-shaping=disabled \
                       -Dtest-text-shaping=false \
                       -Dexamples=false"

if [ "${DISPLAYSERVER}" != "wl" ]; then
  PKG_BUILD_FLAGS="-sysroot"
  PKG_DEPENDS_CONFIG="tllist"
  PKG_MESON_OPTS_TARGET+=" --default-library static"
fi
