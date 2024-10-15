# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nextpvr"
PKG_VERSION="6.1.5~Piers"
PKG_ADDON_VERSION="6.1.5~5"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="NextPVR"
PKG_SITE="https://nextpvr.com"
PKG_DEPENDS_TARGET="toolchain libhdhomerun libmediainfo"
PKG_SECTION="service"
PKG_SHORTDESC="NextPVR Server"
PKG_LONGDESC="NextPVR is a personal video recorder application. It allows to watch or record live TV, provides great features like series recordings and web scheduling."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="NextPVR Server"
PKG_ADDON_TYPE="xbmc.service.library"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.dotnet-runtime:0.0.0 script.module.requests:0.0.0"

addon() {
  :
}

post_install_addon() {
  sed -e "s/@NEXTPVR_VERSION@/${PKG_ADDON_VERSION}/g" -i "${INSTALL}/bin/nextpvr-downloader"

  mkdir -p ${INSTALL}/local
  cp $(get_build_dir libmediainfo)/Project/GNU/Library/.libs/libmediainfo.so* ${INSTALL}/local
  cp -P $(get_build_dir libhdhomerun)/hdhomerun_config ${INSTALL}/local
}
