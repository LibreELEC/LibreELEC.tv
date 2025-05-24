# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="argononecontrol"
PKG_VERSION="1.1.12"
PKG_SHA256="c68b194b4fd3dce6968883282a302fccd705560ce88af243654d505147c61d2c"
PKG_REV="0"
PKG_ARCH="aarch64"
PKG_MAINTAINER="HungerHa"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/HungerHa/libreelec_addon_argononecontrol"
PKG_URL="https://github.com/HungerHa/libreelec_addon_argononecontrol/archive/refs/tags/v$PKG_VERSION.tar.gz"
PKG_SECTION="service"
PKG_SHORTDESC="Argon ONE Control"
PKG_LONGDESC="Support for RPi4/5 Argon ONE case features including the power button, fan speed, and the Argon IR remote. One-time restart required."
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="xmlstarlet:host 7-zip:host"
PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Argon ONE Control"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROJECTS="RPi ARM"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/source/addon.xml ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/changelog.txt ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/README.md ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/source/LICENSE ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/source/default.py ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/source/main.py ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -PR ${PKG_BUILD}/source/resources ${ADDON_BUILD}/${PKG_ADDON_ID}
}

post_install_addon() {
  rm ${ADDON_BUILD}/${PKG_ADDON_ID}/resources/fanart.png
}
