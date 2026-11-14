# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lldpd"
PKG_VERSION="1.0.23"
PKG_SHA256="53f17e05ad3c4e73f1eb961cfc53f7848cd17c3f8ea242f5f9d7891b0ff5c968"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/lldpd/lldpd"
PKG_URL="https://github.com/lldpd/lldpd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libcap libevent"
PKG_SECTION="service"
PKG_SHORTDESC="LLDP: Link Layer Discovery Protocol daemon"
PKG_LONGDESC="lldpd is an implementation of IEEE 802.1ab (LLDP). It advertises this device on the local network and discovers neighbouring switches and their ports (LLDP, and optionally CDP/EDP/FDP/SONMP)."
PKG_TOOLCHAIN="configure"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="LLDP"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="export \
                           --with-sysroot=${SYSROOT_PREFIX} \
                           --localstatedir=/var \
                           --runstatedir=/run \
                           --with-privsep-chroot=/run/lldpd/chroot \
                           --with-lldpd-ctl-socket=/run/lldpd/socket \
                           --with-lldpd-pid-file=/run/lldpd/pid \
                           --without-embedded-libevent \
                           --with-readline=no \
                           --disable-shared \
                           --prefix=/usr \
                           --sysconfdir=/etc \
                           --disable-privsep \
                           --with-privsep-user=_lldpd \
                           --with-privsep-group=_lldpd"

pre_configure_target() {
  ./autogen.sh
}

post_configure_target() {
  sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' libtool
  sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' libtool
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  cp -P ${PKG_INSTALL}/usr/sbin/lldpcli \
        ${PKG_INSTALL}/usr/sbin/lldpd \
        "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
}
