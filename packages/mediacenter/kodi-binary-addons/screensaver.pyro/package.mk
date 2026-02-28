# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.pyro"
PKG_VERSION="22.0.4-Piers"
PKG_SHA256="bb5f515af67e5c3e28917f731215f2589b5b0ed0d6a4f90cc4f225a94b78a3a0"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.pyro"
PKG_URL="https://github.com/xbmc/screensaver.pyro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.pyro"
PKG_LONGDESC="screensaver.pyro"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi
