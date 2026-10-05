# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.stalker"
PKG_VERSION="22.2.7-Piers"
PKG_SHA256="98f5151e4b29c99b6723061bb7cc5514c6307853d8d050c784a5ce93d51142e9"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.stalker"
PKG_URL="https://github.com/kodi-pvr/pvr.stalker/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host jsoncpp libxml2 tinyxml"
PKG_SECTION=""
PKG_SHORTDESC="pvr.stalker"
PKG_LONGDESC="pvr.stalker"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
