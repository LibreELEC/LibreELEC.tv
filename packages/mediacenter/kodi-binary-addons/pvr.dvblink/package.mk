# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.dvblink"
PKG_VERSION="22.3.2-Piers"
PKG_SHA256="0ad2dea8f8932a2510f3fd9b0c41dc4bc4de5c6f621ce475c2bc14c45b8d7228"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.dvblink"
PKG_URL="https://github.com/kodi-pvr/pvr.dvblink/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="pvr.dvblink"
PKG_LONGDESC="pvr.dvblink"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
