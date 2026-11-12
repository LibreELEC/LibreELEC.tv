# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tailscale"
PKG_VERSION="1.104.6"
PKG_REV="14"
PKG_ARCH="any"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://tailscale.com"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Tailscale: private WireGuard made easy"
PKG_LONGDESC="Tailscale (${PKG_VERSION}) creates a secure network between your devices using WireGuard. Connect to your tailnet, use exit nodes, and access local subnets."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tailscale"
PKG_ADDON_ICON_SIZE="170"
PKG_ADDON_TYPE="xbmc.service"

case "${ARCH}" in
  "x86_64")
    PKG_SHA256="82a85429f733e52fd1a95dedb2c8dd8cd46d6603504e566a56b1779c9a7a4809"
    TAILSCALE_ARCH="amd64"
    ;;
  "arm")
    PKG_SHA256="98be19a248544f0d7809b71c2b6c3d1cb200aa347d3d0a47d9034dec5a26fc69"
    TAILSCALE_ARCH="arm"
    ;;
  "aarch64")
    PKG_SHA256="d0e4f297da3c428d02162c6235b9948e4ddc245c64502b7b05647da9b96a0971"
    TAILSCALE_ARCH="arm64"
    ;;
esac

PKG_URL="https://pkgs.tailscale.com/stable/tailscale_${PKG_VERSION}_${TAILSCALE_ARCH}.tgz"

unpack() {
  mkdir -p ${PKG_BUILD}
    tar xzf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tgz -C ${PKG_BUILD} --strip-components=1
}

make_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/tailscale ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/tailscaled ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
