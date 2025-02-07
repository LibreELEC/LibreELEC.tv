# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="argonforty-device"
PKG_VERSION="1.1.5"
PKG_SHA256="c8741aa97ae5f9ef3159d03f1e2a5e6ea886eb8dec5797aeee1c68a247734f09"
PKG_REV="0"
PKG_ARCH="arm aarch64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/HungerHa/libreelec_package_argonforty-device"
PKG_URL="https://github.com/HungerHa/libreelec_package_argonforty-device/archive/refs/tags/v$PKG_VERSION.tar.gz"
PKG_SECTION="script.service"
PKG_SHORTDESC="ArgonForty Device Configuration"
PKG_LONGDESC="Support for the RPi4/5 Argon ONE cases. Installs services to manage ArgonForty devices, such as power button, fan speed and Argon REMOTE. This also activates I2C, IR receiver and UART (requires a one-time restart)."
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="xmlstarlet:host 7-zip:host"
PKG_IS_ADDON="yes"
PKG_ADDON_NAME="ArgonForty Device Configuration"
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
