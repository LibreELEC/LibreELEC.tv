# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asterwave"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="132a97e0bf0983faf9cbbaa67b106e6131246a3d41245af5c48789b9d2686909"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.asterwave"
PKG_URL="https://github.com/xbmc/screensaver.asterwave/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform glm"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.asterwave"
PKG_LONGDESC="screensaver.asterwave"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi

if [ "${DISPLAYSERVER}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET="-DCORE_PLATFORM_NAME=gbm"
fi
