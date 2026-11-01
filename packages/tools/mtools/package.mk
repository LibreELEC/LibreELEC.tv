# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtools"
PKG_VERSION="4.0.50"
PKG_SHA256="f3a58e6cfc2634b03c240442548e3b00103692357afc28e1e7104744dd6478b5"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="http://www.gnu.org/software/mtools/"
PKG_URL="https://ftpmirror.gnu.org/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="autotools:host"
PKG_LONGDESC="mtools: A collection of utilities to access MS-DOS disks"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs:host"
