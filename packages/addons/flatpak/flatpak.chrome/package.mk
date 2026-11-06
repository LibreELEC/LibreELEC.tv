# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flatpak.chrome"
PKG_VERSION="0"
PKG_REV="1"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://www.google.com/chrome/"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Chrome Web Browser"
PKG_LONGDESC="This is the flatpak version of the Chrome Web Browser.\nUse the Flatpak addon to update it."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Chrome"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.flatpak:0.0.0"

PKG_IS_FLATPAK_ADDON="yes"
PKG_FLATPAK_APPID="com.google.Chrome"
PKG_FLATPAK_START_ARGS="'--no-sandbox'"

addon() {
  :
}
