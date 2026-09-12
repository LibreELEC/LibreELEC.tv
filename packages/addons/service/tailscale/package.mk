# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tailscale"
PKG_VERSION="1.102.4"
PKG_REV="9"
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
    PKG_SHA256="50748df1045e60b5b695f19f4c56b0da36c019948b440fb456b6584a50f0d8b9"
    TAILSCALE_ARCH="amd64"
    ;;
  "arm")
    PKG_SHA256="b981a59cb85fb923ee6e1860ee6934772c83a840a6627f0dbfd7711ed690b869"
    TAILSCALE_ARCH="arm"
    ;;
  "aarch64")
    PKG_SHA256="9dd1e6a592a014bbaea0103167ffe299adeda4ba14e078ce9c2895364f6c4c3f"
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
