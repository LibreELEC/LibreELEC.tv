# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="network"
PKG_VERSION=""
PKG_LICENSE="various"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain connman netbase ethtool openssh iw wireless-regdb nss ipset"
PKG_SECTION="virtual"
PKG_LONGDESC="Metapackage for various packages to install network support"

if [ "${BLUETOOTH_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" bluez"
fi

if [ "${SAMBA_SERVER}" = "yes" ] || [ "${SAMBA_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" samba"
fi

if [ "${SAMBA_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" cifs-utils"
fi

if [ "${OPENVPN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" openvpn"
fi

if [ "${WIREGUARD_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" wireguard-tools"
fi

if [ "${ISCSI_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" open-iscsi"
fi

if [ "${NFS_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" nfs-utils"
fi
