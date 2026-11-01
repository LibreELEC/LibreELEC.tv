# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lcms2"
PKG_VERSION="2.20"
PKG_SHA256="18ff5504fa9cc8a2b1f3591180d90ead16c8a2ea78e530523b46eab70e1ca6b9"
PKG_LICENSE="MIT"
PKG_SITE="http://www.littlecms.com"
PKG_URL="https://github.com/mm2/Little-CMS/releases/download/lcms${PKG_VERSION}/lcms2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tiff"
PKG_LONGDESC="An small-footprint color management engine, with special focus on accuracy and performance."
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddefault_library=static \
                       -Dprefer_static=true \
                       -Dtests=disabled \
                       -Dutils=true"
