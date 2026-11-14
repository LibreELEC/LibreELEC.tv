# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.vuplus"
PKG_VERSION="22.3.7-Piers"
PKG_SHA256="2c677b914be2262fe3114a01066efabb3d3450d4bbc76eeaf942b77f31cdc3c7"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.vuplus"
PKG_URL="https://github.com/kodi-pvr/pvr.vuplus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json"
PKG_SECTION=""
PKG_SHORTDESC="pvr.vuplus"
PKG_LONGDESC="pvr.vuplus"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
