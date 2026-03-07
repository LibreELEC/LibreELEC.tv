# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.nextpvr"
PKG_VERSION="22.5.2-Piers"
PKG_SHA256="679a0061227d157ad3ab40e7e0f48b64e31924af74862910728eee149af3473b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.nextpvr"
PKG_URL="https://github.com/kodi-pvr/pvr.nextpvr/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform tinyxml2 zlib"
PKG_SECTION=""
PKG_SHORTDESC="pvr.nextpvr"
PKG_LONGDESC="pvr.nextpvr"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS+=" -Wno-narrowing"
}
