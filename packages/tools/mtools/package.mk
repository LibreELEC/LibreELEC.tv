# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtools"
PKG_VERSION="4.0.45"
PKG_SHA256="0b008a96bd0efe0e542fa4383d469af66bc4a93394990b103730a8160a67d618"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/mtools/"
PKG_URL="http://ftpmirror.gnu.org/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="autotools:host"
PKG_LONGDESC="mtools: A collection of utilities to access MS-DOS disks"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs:host"
