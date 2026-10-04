# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lcdd"
PKG_VERSION="0be7b90354e91d430edb3b650d817edb8f4bb8d7"
PKG_SHA256="c92fb4a6be87c6a7e6374ae7f9d3e1810304d1b6d3db4e7882eee0a2fafb30a2"
PKG_VERSION_DATE="0.5dev+2026-06-20"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://lcdproc.org/"
PKG_URL="https://github.com/lcdproc/lcdproc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain freetype libftdi1 libgpiod libhid libugpio libusb ncurses serdisplib"
PKG_DEPENDS_CONFIG="libgpiod"
PKG_SECTION="service"
PKG_SHORTDESC="LCDproc: Software to display system information from your Linux/*BSD box on a LCD"
PKG_LONGDESC="LCDproc (${PKG_VERSION}) is a piece of software that displays real-time system information from your Linux/*BSD box on a LCD. The server supports several serial devices: Matrix Orbital, Crystal Fontz, Bayrad, LB216, LCDM001 (kernelconcepts.de), Wirz-SLI, Cwlinux(.com) and PIC-an-LCD; and some devices connected to the LPT port: HD44780, STV5730, T6963, SED1520 and SED1330. Various clients are available that display things like CPU load, system load, memory usage, uptime, and a lot more."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-parallel -cfg-libs"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="LCDproc"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--enable-drivers=all \
                           --enable-freetype \
                           --enable-libhid \
                           --enable-libftdi \
                           --disable-libpng \
                           --enable-libusb \
                           --disable-libX11"

pre_configure_target() {
  CFLAGS+=" -O3"
}

addon() {
  drivers="none|$(cat ${PKG_BUILD}/.${TARGET_NAME}/config.log | sed -n "s|^DRIVERS=' \(.*\)'|\1|p" | sed "s|.so||g" | tr ' ' '|')"

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/config

  cp -PR ${PKG_DIR}/resources ${ADDON_BUILD}/${PKG_ADDON_ID}

  cp -PR ${PKG_INSTALL}/etc/LCDd.conf ${ADDON_BUILD}/${PKG_ADDON_ID}/config/
  cp -PR ${PKG_INSTALL}/usr/lib       ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/
  patchelf --add-rpath '${ORIGIN}/../../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/lcdproc/glcd.so
  patchelf --add-rpath '${ORIGIN}/../../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/lcdproc/hd44780.so
  cp -PR ${PKG_INSTALL}/usr/sbin      ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
  cp -L $(get_install_dir libgpiod)/usr/lib/libgpiod.so.3 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
  cp -L $(get_install_dir serdisplib)/usr/lib/libserdisp.so.2 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

  sed -e "s|^DriverPath=.*$|DriverPath=/storage/.kodi/addons/service.lcdd/lib/lcdproc/|" \
      -e "s|^#Foreground=.*$|Foreground=no|" \
      -e "s|^#ServerScreen=.*$|ServerScreen=blank|" \
      -e "s|^#Backlight=.*$|Backlight=open|" \
      -e "s|^#Heartbeat=.*$|Heartbeat=open|" \
      -e "s|^#TitleSpeed=.*$|TitleSpeed=4|" \
      -e "s|^#Hello=\"  Welcome to\"|Hello=\"Welcome to\"|" \
      -e "s|^#Hello=\"   LCDproc!\"|Hello=\"${DISTRONAME}\"|" \
      -e "s|^#GoodBye=\"Thanks for using\"|GoodBye=\"Thanks for using\"|" \
      -e "s|^#GoodBye=\"   LCDproc!\"|GoodBye=\"${DISTRONAME}\"|" \
      -e "s|^#normal_font=.*$|normal_font=/usr/share/fonts/liberation/LiberationMono-Bold.ttf|" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/config/LCDd.conf

  sed -e "s/@DRIVERS@/${drivers}/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/resources/settings.xml
}
