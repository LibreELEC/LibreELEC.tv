# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022 Team LibreELEC (https://libreelec.tv)

PKG_NAME="less"
PKG_VERSION="643"
PKG_SHA256="2911b5432c836fa084c8a2e68f6cd6312372c026a58faaa98862731c8b6052e8"
PKG_LICENSE="GPL3"
PKG_SITE="http://www.greenwoodsoftware.com/"
PKG_URL="http://www.greenwoodsoftware.com/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Text file viewer similar to more"
PKG_BUILD_FLAGS="-sysroot"
