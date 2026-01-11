# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liblognorm"
PKG_VERSION="2.0.9"
PKG_SHA256="5ba04e808f6530592b699e0994fd00fab84c1e323885d9be6dc91f4919f57801"
PKG_LICENSE="GPL"
PKG_SITE="https://www.liblognorm.com"
PKG_URL="https://github.com/rsyslog/liblognorm/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libestr libfastjson"
PKG_TOOLCHAIN="autotools"
PKG_LONGDESC="A fast samples-based log normalization library."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
