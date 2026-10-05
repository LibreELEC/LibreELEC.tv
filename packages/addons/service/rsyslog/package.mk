# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsyslog"
PKG_VERSION="8.2608.0"
PKG_SHA256="e3d60c83405268c422f95feec740455a1cc4b911d00bd8424d5d1272bc509b1a"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/rsyslog"
PKG_URL="https://www.rsyslog.com/files/download/rsyslog/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain protobuf-c:host curl libestr libfastjson libgcrypt liblogging liblognorm librelp libyaml protobuf-c snappy util-linux zlib"
PKG_DEPENDS_CONFIG="protobuf-c snappy libyaml"
PKG_SECTION="service"
PKG_SHORTDESC="Rsyslog: a rocket-fast system for log processing."
PKG_LONGDESC="Rsyslog (${PKG_VERSION}) offers high-performance, great security features and a modular design."
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Rsyslog"
PKG_ADDON_ICON_NAME="none"
PKG_ADDON_ICON_SIZE="320"
PKG_ADDON_ICON_OFFSET='+5'
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--disable-default-tests \
                           --enable-imfile \
                           --enable-imjournal \
                           --enable-relp \
                           --enable-omjournal \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"

export LIBGCRYPT_CONFIG="${SYSROOT_PREFIX}/usr/bin/libgcrypt-config"

pre_configure_target() {
  CFLAGS+=" -fcommon"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp ${PKG_INSTALL}/usr/sbin/rsyslogd \
     ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/rsyslog
  for l in $(find ${PKG_INSTALL}/usr/lib -name *.so); do
    cp ${l} ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/rsyslog/
  done
}
