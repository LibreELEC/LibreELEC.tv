# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.vdr.vnsi"
PKG_VERSION="22.2.2-Piers"
PKG_SHA256="1b7697dad07d89fa8f1431c5396515de8085d67ea42c22c2b31aac9bf0769b5a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.vdr.vnsi"
PKG_URL="https://github.com/kodi-pvr/pvr.vdr.vnsi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="pvr.vdr.vnsi"
PKG_LONGDESC="pvr.vdr.vnsi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi
