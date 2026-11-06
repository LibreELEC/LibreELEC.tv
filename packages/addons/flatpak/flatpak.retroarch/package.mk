# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flatpak.retroarch"
PKG_VERSION="0"
PKG_REV="1"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://supertuxkart.net/"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="RetroArch"
PKG_LONGDESC="This is the flatpak version of RetroArch.\nUse the Flatpak addon to update it."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="RetroArch"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_ICON_SIZE="300"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.flatpak:0.0.0"

PKG_IS_FLATPAK_ADDON="yes"
PKG_FLATPAK_APPID="org.libretro.RetroArch"

addon() {
  :
}
