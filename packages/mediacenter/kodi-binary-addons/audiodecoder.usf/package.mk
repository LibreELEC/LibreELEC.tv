# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.usf"
PKG_VERSION="22.0.1-Piers"
PKG_SHA256="de970be6d0c804ce7dc0fb2113a618b5e4c07866212e3b8909e92665aa3524e2"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/audiodecoder.usf"
PKG_URL="https://github.com/xbmc/audiodecoder.usf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.usf"
PKG_LONGDESC="audiodecoder.usf"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
PKG_ADDON_PROJECTS="any !RPi1 !Slice"
