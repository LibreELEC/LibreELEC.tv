# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.usf"
PKG_VERSION="22.0.2-Piers"
PKG_SHA256="e63124f18d7d8efd66e4f3cbc9336a61c28697a19a5b73ee16fe52d4dec405e3"
PKG_REV="1"
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
