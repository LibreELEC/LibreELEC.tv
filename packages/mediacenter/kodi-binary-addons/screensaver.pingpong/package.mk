# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.pingpong"
PKG_VERSION="22.0.4-Piers"
PKG_SHA256="4e9e35274ab449d3f5adeb0a548e3c8de8e444f9f8637c767aa9144175d9815e"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.pingpong"
PKG_URL="https://github.com/xbmc/screensaver.pingpong/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform glm"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.pingpong"
PKG_LONGDESC="screensaver.pingpong"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi
