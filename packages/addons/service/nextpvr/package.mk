# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nextpvr"
PKG_VERSION="7.0.4"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="NextPVR"
PKG_SITE="https://nextpvr.com"
PKG_DEPENDS_TARGET="toolchain libhdhomerun libmediainfo comskip"
PKG_SECTION="service"
PKG_SHORTDESC="NextPVR Server"
PKG_LONGDESC="NextPVR ${PKG_VERSION} is an advanced personal video recorder server for Windows, macOS and Linux that allows watching live TV and recordings, and advanced scheduling recordings from client devices and browsers"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="NextPVR Server"
PKG_ADDON_TYPE="xbmc.service.library"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.dotnet-runtime:0.0.0 script.module.requests:0.0.0"

addon() {
  :
}

post_install_addon() {
  sed -e "s/@NEXTPVR_VERSION@/${PKG_VERSION}/g" -i "${INSTALL}/bin/nextpvr-downloader"

  mkdir -p ${INSTALL}/{lbin,lib.private}
  cp $(get_build_dir libmediainfo)/Project/GNU/Library/.libs/libmediainfo.so ${INSTALL}/lib.private
  cp -P $(get_build_dir libhdhomerun)/hdhomerun_config ${INSTALL}/lbin
  cp -P $(get_install_dir comskip)/usr/bin/comskip ${INSTALL}/lbin
  if [ "${TARGET_ARCH}" = "aarch64" ] || [ "${TARGET_ARCH}" = "x86_64" ]; then
    cp -P $(get_install_dir x265)/usr/lib/libx265.so.215 ${INSTALL}/lib.private
    patchelf --add-rpath '${ORIGIN}/../lib.private' ${INSTALL}/lbin/comskip
  fi
}
