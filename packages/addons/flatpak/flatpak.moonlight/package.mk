# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flatpak.moonlight"
PKG_VERSION="0"
PKG_REV="2"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://moonlight-stream.org/"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Moonlight streaming client"
PKG_LONGDESC="This is the flatpak version of Moonlight.\nUse the Flatpak addon to update it."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Moonlight"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.flatpak:0.0.0"

PKG_IS_FLATPAK_ADDON="yes"
PKG_FLATPAK_APPID="com.moonlight_stream.Moonlight"
PKG_FLATPAK_AUDIO_SETTINGS="yes"

addon() {
  :
}
