# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asterwave"
PKG_VERSION="22.0.5-Piers"
PKG_SHA256="049ddd84606576439531a76f04bf6732ecab1776d151a5bfe7b69a1a488080ee"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/screensaver.asterwave"
PKG_URL="https://github.com/xbmc/screensaver.asterwave/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
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
