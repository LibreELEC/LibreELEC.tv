# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.dvbviewer"
PKG_VERSION="22.3.2-Piers"
PKG_SHA256="962c47a949377bf22f45b8af4c271fef409971ff06e24db1bfc379ada84cf7b2"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.dvbviewer"
PKG_URL="https://github.com/kodi-pvr/pvr.dvbviewer/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="pvr.dvbviewer"
PKG_LONGDESC="pvr.dvbviewer"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
