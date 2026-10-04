# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asteroids"
PKG_VERSION="22.0.6-Piers"
PKG_SHA256="5682dd86180706b6bee99a3b16797378b68d64832abf8fde180e6e5da741e07a"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/screensaver.asteroids"
PKG_URL="https://github.com/xbmc/screensaver.asteroids/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.asteroids"
PKG_LONGDESC="screensaver.asteroids"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"
