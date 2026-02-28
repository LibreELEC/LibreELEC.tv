# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.timidity"
PKG_VERSION="22.0.2-Piers"
PKG_SHA256="b7d2a61b09e9cd8742391452d4f9b176892aca99353aab1515bd987d1909df7d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/audiodecoder.timidity"
PKG_URL="https://github.com/xbmc/audiodecoder.timidity/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.timidity"
PKG_LONGDESC="audiodecoder.timidity"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"

pre_configure_target() {
  CFLAGS+=" -fcommon"
}

addon() {
  install_binary_addon ${PKG_ADDON_ID}

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}
    cp -P ${PKG_BUILD}/.${TARGET_NAME}/lib/timidity/libtimidity_*.so ${ADDON_BUILD}/${PKG_ADDON_ID}/
}
