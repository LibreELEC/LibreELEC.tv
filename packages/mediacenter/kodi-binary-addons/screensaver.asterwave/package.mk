# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asterwave"
PKG_VERSION="22.0.2-Piers"
PKG_SHA256="7df1c7a91faac455d392a5f176ec318283d87188d4457af6484df39355e8c8ea"
PKG_REV="4"
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
