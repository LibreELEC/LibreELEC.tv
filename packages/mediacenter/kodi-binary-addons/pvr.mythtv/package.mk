# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.mythtv"
PKG_VERSION="22.3.4-Piers"
PKG_SHA256="80cc8707b6fa6615678e3ca5dcc3770f2a5d96b102bd0d2e145610c23e213cde"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/janbar/pvr.mythtv"
PKG_URL="https://github.com/janbar/pvr.mythtv/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host zlib"
PKG_SECTION=""
PKG_SHORTDESC="pvr.mythtv"
PKG_LONGDESC="pvr.mythtv"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
