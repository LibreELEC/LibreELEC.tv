# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026 Rémi Collignon-Ducret (miton18)
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hueambi"
PKG_VERSION="0.3.0"
PKG_SHA256="82319714c2e4593e0d10d3e503ed82903e1615ea59b509a6f8e480d1a6347d3f"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/miton18/hue-ambi"
PKG_URL="https://github.com/miton18/hue-ambi/archive/v${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="hue-ambi-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain openssl cargo:host"
PKG_SECTION="service"
PKG_SHORTDESC="Hue Ambi: Philips Hue ambilight from the picture on screen"
PKG_LONGDESC="Hue Ambi (${PKG_VERSION}) reads the picture straight from the display controller and drives a Philips Hue entertainment area: each light takes the colour of the part of the picture it faces. Raspberry Pi 5 only. Needs a Hue bridge with an entertainment area and the Direct To Plane video renderer."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
# source/addon.xml is shipped (context menu item); keep the LibreELEC add-on numbering
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"
PKG_ADDON_NAME="Hue Ambi"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROJECTS="ARMv8"
PKG_MAINTAINER="Rémi Collignon-Ducret (miton18)"

make_target() {
  export RUSTC_LINKER=${CC}
  # --no-default-features: link LibreELEC's OpenSSL instead of the vendored one
  cargo build \
    --manifest-path ${PKG_BUILD}/engine/Cargo.toml \
    --target ${TARGET_NAME} \
    --release \
    --locked \
    --no-default-features

  ${STRIP} ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/hue-ambi
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/hue-ambi \
       ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  # Kodi side from the upstream release: service, settings, translations
  cp -PR ${PKG_BUILD}/service.hueambi/default.py \
         ${PKG_BUILD}/service.hueambi/resources \
         ${ADDON_BUILD}/${PKG_ADDON_ID}
}
