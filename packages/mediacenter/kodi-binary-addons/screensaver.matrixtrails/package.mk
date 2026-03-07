# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.matrixtrails"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="19b618c889843fc1bacc7a648513ad526ef781ffb7d6b0819ade40735a1b883a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.matrixtrails"
PKG_URL="https://github.com/xbmc/screensaver.matrixtrails/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.matrixtrails"
PKG_LONGDESC="screensaver.matrixtrails"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi

if [ "${DISPLAYSERVER}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET="-DCORE_PLATFORM_NAME=gbm"
fi
