# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019 Team LibreELEC (https://libreelec.tv)

PKG_NAME="connman"
PKG_VERSION="1e1d2af009efc8a8b65eccc06188bd6b28271af7" # 1.41+ / 2022-05-25
PKG_SHA256="bfdc7a8261c476c003df59a2952090dacf67c78b97027f06db3280edce0d4ee5"
PKG_LICENSE="GPL"
PKG_SITE="http://www.connman.net"
PKG_URL="https://git.kernel.org/pub/scm/network/connman/connman.git/snapshot/connman-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib readline dbus iptables"
PKG_LONGDESC="A modular network connection manager."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--srcdir=.. \
                           --disable-debug \
                           --disable-hh2serial-gps \
                           --disable-openconnect \
                           --disable-openvpn \
                           --disable-vpnc \
                           --disable-l2tp \
                           --disable-pptp \
                           --disable-iospm \
                           --disable-tist \
                           --disable-session-policy-local \
                           --disable-test \
                           --disable-nmcompat \
                           --disable-polkit \
                           --disable-selinux \
                           --enable-loopback \
                           --enable-ethernet \
                           --disable-gadget \
                           --disable-bluetooth \
                           --disable-ofono \
                           --disable-dundee \
                           --disable-pacrunner \
                           --disable-neard \
                           --disable-wispr \
                           --disable-tools \
                           --disable-stats \
                           --enable-client \
                           --enable-datafiles \
                           --with-dbusconfdir=/etc \
                           --with-systemdunitdir=/usr/lib/systemd/system \
                           --disable-silent-rules"

if [ "${WIREGUARD_SUPPORT}" = "yes" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-wireguard=builtin"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-wireguard"
fi

case "${WIRELESS_DAEMON}" in
  wpa_supplicant)
    PKG_DEPENDS_TARGET+=" wpa_supplicant"
    PKG_CONFIGURE_OPTS_TARGET+=" WPASUPPLICANT=/usr/bin/wpa_supplicant \
                                 --enable-wifi \
                                 --disable-iwd"
    ;;
  iwd)
    PKG_DEPENDS_TARGET+=" iwd"
    PKG_CONFIGURE_OPTS_TARGET+=" --disable-wifi \
                                 --enable-iwd"
    ;;
esac

PKG_MAKE_OPTS_TARGET="storagedir=/storage/.cache/connman \
                      vpn_storagedir=/storage/.config/wireguard \
                      statedir=/run/connman"

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/lib/systemd
  rm -rf ${INSTALL}/usr/lib/tmpfiles.d/connman_resolvconf.conf

  mkdir -p ${INSTALL}/usr/bin
    cp -P client/connmanctl ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/lib/connman
    cp -P ${PKG_DIR}/scripts/connman-setup ${INSTALL}/usr/lib/connman

  mkdir -p ${INSTALL}/etc/connman
    cp ../src/main.conf ${INSTALL}/etc/connman
    sed -i ${INSTALL}/etc/connman/main.conf \
        -e "s|^# BackgroundScanning.*|BackgroundScanning = true|g" \
        -e "s|^# UseGatewaysAsTimeservers.*|UseGatewaysAsTimeservers = false|g" \
        -e "s|^# FallbackNameservers.*|FallbackNameservers = 8.8.8.8,8.8.4.4|g" \
        -e "s|^# FallbackTimeservers.*|FallbackTimeservers = 0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org|g" \
        -e "s|^# PreferredTechnologies.*|PreferredTechnologies = ethernet,wifi,cellular|g" \
        -e "s|^# TetheringTechnologies.*|TetheringTechnologies = wifi|g" \
        -e "s|^# AllowHostnameUpdates.*|AllowHostnameUpdates = false|g" \
        -e "s|^# PersistentTetheringMode.*|PersistentTetheringMode = true|g" \
        -e "s|^# NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb|NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb,docker,veth,zt|g"

  mkdir -p ${INSTALL}/usr/share/connman/
    cp ${PKG_DIR}/config/settings ${INSTALL}/usr/share/connman/
}

post_install() {
  add_user system x 430 430 "service" "/var/run/connman" "/bin/sh"
  add_group system 430

  enable_service connman.service
  if [ "${WIREGUARD_SUPPORT}" = "yes" ]; then
    enable_service connman-vpn.service
  fi
}
