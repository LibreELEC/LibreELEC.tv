# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wireplumber"
PKG_VERSION="0.5.19"
PKG_SHA256="f9454eae3a5a6ca903c05ead2a7e47d7d3957fb0ffac3ebb11d92842603ae80f"
PKG_LICENSE="MIT"
PKG_SITE="https://gitlab.freedesktop.org/pipewire/wireplumber"
PKG_URL="https://gitlab.freedesktop.org/pipewire/wireplumber/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="pipewire glib lua54"
PKG_LONGDESC="Session / policy manager implementation for PipeWire"

PKG_MESON_OPTS_TARGET="-Dintrospection=disabled \
                       -Ddoc=disabled \
                       -Dsystem-lua=true \
                       -Delogind=disabled \
                       -Dsystemd=enabled \
                       -Dsystemd-system-service=true \
                       -Dsystemd-user-service=false \
                       -Dsystemd-system-unit-dir=/usr/lib/systemd/system \
                       -Dtests=false"

post_makeinstall_target() {
  # connect to the system bus
  sed '/^\[Service\]/a Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket' -i ${INSTALL}/usr/lib/systemd/system/wireplumber.service

  # ref https://gitlab.freedesktop.org/pipewire/wireplumber/-/commit/0da29f38181e391160fa8702623050b8544ec775
  # ref https://github.com/PipeWire/wireplumber/blob/master/docs/rst/daemon/configuration/migration.rst
  # ref https://github.com/PipeWire/wireplumber/blob/master/docs/rst/daemon/configuration/features.rst
  cat >${INSTALL}/usr/share/wireplumber/wireplumber.conf.d/89-disable-session-dbus-dependent-features.conf <<EOF
wireplumber.profiles = {
  main = {
    monitor.alsa.reserve-device = disabled
    monitor.bluez.seat-monitoring = disabled
    support.portal-permissionstore = disabled
  }
}
EOF

  cat >${INSTALL}/usr/share/wireplumber/wireplumber.conf.d/89-disable-v4l2.conf <<EOF
wireplumber.profiles = {
  main = {
    monitor.v4l2 = disabled
  }
}
EOF

  cat >${INSTALL}/usr/share/wireplumber/wireplumber.conf.d/89-disable-bluez-hfphsp-backend.conf <<EOF
monitor.bluez.properties = {
  bluez5.hfphsp-backend = "none"
}
EOF
}

post_install() {
  enable_service wireplumber.service
}
