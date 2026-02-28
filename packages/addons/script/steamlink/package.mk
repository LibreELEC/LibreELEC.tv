# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="steamlink"
PKG_VERSION="1.0"
PKG_REV="0"
PKG_ARCH="aarch64"
PKG_LICENSE="custom"
PKG_SITE="https://support.steampowered.com/kb_article.php?ref=6153-IFGH-6589"
PKG_DEPENDS_TARGET="double-conversion krb5 md4c zstd steamlink-libepoxy steamlink-ffmpeg steamlink-libjpeg-turbo steamlink-libpng steamlink-mtdev steamlink-wayland"
PKG_SECTION="script.program"
PKG_SHORTDESC="Steam Link App for Raspberry Pi"
PKG_LONGDESC="Installs the Steam Link App for Raspberry Pi from Valve for use in streaming from Steam clients. Addon is not associated with Valve. Use of Steam Link software is subject to the Steam Subscriber Agreement."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Raspberry Pi Steam Link"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES="executable"

PKG_STEAMLINK_VERSION="1.3.22.298"
PKG_STEAMLINK_HASH="0d4ed006b35a3098c713ea782b9d4fba678e6d16fbf7cb95e3a2626af83e3ce8"

addon() {
  # Add needed libraries
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/resources
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs

  # double-conversion
  cp -L $(get_install_dir double-conversion)/usr/lib/libdouble-conversion.so.3 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # ffmpeg
  cp -L $(get_install_dir steamlink-ffmpeg)/usr/lib/libavcodec.so.61 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir steamlink-ffmpeg)/usr/lib/libavutil.so.59 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir steamlink-ffmpeg)/usr/lib/libswresample.so.5 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # krb5
  cp -L $(get_install_dir krb5)/usr/lib/libkrb5.so.3 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir krb5)/usr/lib/libgssapi_krb5.so.2 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir krb5)/usr/lib/libk5crypto.so.3 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir krb5)/usr/lib/libcom_err.so.3 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir krb5)/usr/lib/libkrb5support.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # md4c
  cp -L $(get_install_dir md4c)/usr/lib/libmd4c.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # libepoxy
  cp -L $(get_install_dir steamlink-libepoxy)/usr/lib/libepoxy.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # libjpeg-turbo
  cp -L $(get_install_dir steamlink-libjpeg-turbo)/usr/lib/libjpeg.so.62 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # libpng
  cp -L $(get_install_dir steamlink-libpng)/usr/lib/libpng16.so.16 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # mtdev
  cp -L $(get_install_dir steamlink-mtdev)/usr/lib/libmtdev.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/

  # wayland
  cp -L $(get_install_dir steamlink-wayland)/usr/lib/libwayland-client.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
  cp -L $(get_install_dir steamlink-wayland)/usr/lib/libwayland-egl.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/system-libs/
}

post_install_addon() {
  # Add steamlink version to download to addon
  sed -e "s/@STEAMLINK_VERSION@/${PKG_STEAMLINK_VERSION}/" \
      -e "s/@STEAMLINK_HASH@/${PKG_STEAMLINK_HASH}/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/default.py
}
