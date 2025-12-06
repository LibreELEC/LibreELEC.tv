# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minisatip"
PKG_VERSION="2.0.43"
PKG_SHA256="8c2fae9abf2950333f86e59b96a49789772a8eea2e3e62b1e977df04cfa38710"
PKG_REV="9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/catalinii/minisatip"
PKG_URL="https://github.com/catalinii/minisatip/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvbcsa libxml2 openssl"
PKG_SECTION="service"
PKG_SHORTDESC="minisatip: a Sat>IP streaming server for Linux"
PKG_LONGDESC="minisatip(${PKG_VERSION_NUMBER}): is a Sat>IP streaming server for Linux supporting DVB-C, DVB-S/S2, DVB-T/T2, ATSC and ISDB-T"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Minisatip"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--disable-netcv \
                           --enable-dvbca \
                           --enable-dvbcsa"

pre_configure_target() {
  TARGET_CONFIGURE_OPTS=$(echo ${TARGET_CONFIGURE_OPTS} | sed -e "s|--disable-static||" -e "s|--enable-shared||")
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_BUILD}/minisatip ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/webif
    cp -PR ${PKG_BUILD}/html/* ${ADDON_BUILD}/${PKG_ADDON_ID}/webif
}
