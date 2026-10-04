# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.demo"
PKG_VERSION="22.4.5-Piers"
PKG_SHA256="723f3c31f41abbb97fd2b57c62d8c4ae82568f4c4bb904248dc6287a51f9521f"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.demo"
PKG_URL="https://github.com/kodi-pvr/pvr.demo/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="pvr.demo"
PKG_LONGDESC="pvr.demo"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
