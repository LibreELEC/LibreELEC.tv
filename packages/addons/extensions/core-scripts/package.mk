# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="core-scripts"
PKG_VERSION="1.0"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_SECTION="service"
PKG_SHORTDESC="Install core system scripts for LibreELEC"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Core System Scripts for LibreELEC"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES="executable"

make_target() {
  :
}

addon() {
  :
}

post_install_addon() {
  # Add values to pass systemd-sysext version validation
  sed -e "s/@DISTRONAME@/${DISTRONAME,,}/" \
      -e "s/@VERSION_ID@/${OS_VERSION}/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/extension-release.d/extension-release.core-scripts
}
