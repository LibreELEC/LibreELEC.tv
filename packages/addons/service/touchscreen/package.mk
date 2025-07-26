# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="touchscreen"
PKG_VERSION="1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="Generic RPi ARM"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Add-on removed"
PKG_LONGDESC="Add-on removed"
PKG_TOOLCHAIN="manual"

PKG_ADDON_BROKEN="Touchscreen no longer required thus removed."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Touchscreen"
PKG_ADDON_TYPE="xbmc.broken"

addon() {
  :
}
