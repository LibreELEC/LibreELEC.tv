# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="firefox"
PKG_VERSION="1.0"
PKG_VERSION_NUMBER="140.6.0esr"
PKG_REV="0"
PKG_ARCH="x86_64"
PKG_LICENSE="Custom"
PKG_SITE="https://www.firefox.com"
PKG_DEPENDS_TARGET="toolchain at-spi2-core atk gdk-pixbuf gtk3 libXcursor pango apulse firefox-pciutils"
PKG_SECTION="browser"
PKG_SHORTDESC="Firefox ESR Browser"
PKG_LONGDESC="Firefox ESR Browser"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Firefox ESR"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_PROJECTS="Generic-legacy"

make_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,config,lib.private,lib.private/apulse,resources}

  # config
  cp -P ${PKG_DIR}/config/* ${ADDON_BUILD}/${PKG_ADDON_ID}/config

  # libs
  cp -PL $(get_install_dir atk)/usr/lib/libatk-1.0.so.0 \
         $(get_install_dir gdk-pixbuf)/usr/lib/libgdk_pixbuf-2.0.so.0 \
         $(get_install_dir gtk3)/usr/lib/{libgtk-3.so.0,libgdk-3.so.0} \
         $(get_install_dir at-spi2-core)/usr/lib/{libatk-bridge-2.0.so.0,libatspi.so.0} \
         $(get_install_dir libXcursor)/usr/lib/libXcursor.so.1 \
         $(get_install_dir pango)/usr/lib/{libpangocairo-1.0.so.0,libpango-1.0.so.0,libpangoft2-1.0.so.0} \
         $(get_install_dir firefox-pciutils)/usr/lib/libpci.so.3 \
         ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
  cp -PL $(get_install_dir apulse)/usr/lib/apulse/{libpulse-simple.so.0,libpulse.so.0,libpulse-mainloop-glib.so.0} \
         ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/apulse
}

post_install_addon() {
  sed -e "s/@DISTRO_PKG_SETTINGS_ID@/${DISTRO_PKG_SETTINGS_ID}/g" -i "${INSTALL}/default.py"
  sed -e "s/@FIREFOX_VERSION@/${PKG_VERSION_NUMBER}/g" -i "${INSTALL}/bin/firefox-downloader"
  sed -e "s/@FIREFOX_VERSION@/${PKG_VERSION_NUMBER}/g" -i "${INSTALL}/resources/settings.xml"
  sed -e "s/@FIREFOX_VERSION@/${PKG_VERSION_NUMBER}/g" -i "${INSTALL}/settings-default.xml"
}
