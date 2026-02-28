# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.mediaportal.tvserver"
PKG_VERSION="22.2.2-Piers"
PKG_SHA256="cfd49402a0fd2604b0f915ac6ed20506a0f636ddb1764c1085f0757226442a1f"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.mediaportal.tvserver"
PKG_URL="https://github.com/kodi-pvr/pvr.mediaportal.tvserver/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="pvr.mediaportal.tvserver"
PKG_LONGDESC="pvr.mediaportal.tvserver"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS+=" -Wno-narrowing -DXLOCALE_NOT_USED"
}
