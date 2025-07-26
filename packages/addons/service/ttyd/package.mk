# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ttyd"
PKG_VERSION="1.7.7"
PKG_SHA256="039dd995229377caee919898b7bd54484accec3bba49c118e2d5cd6ec51e3650"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/tsl0922/ttyd"
PKG_URL="https://github.com/tsl0922/ttyd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libwebsockets zlib"
PKG_SECTION="service"
PKG_SHORTDESC="ttyd: a tool for accessing the terminal over a browser"
PKG_LONGDESC="ttyd (${PKG_VERSION}): is a simple command-line tool for sharing terminal over the web"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Web SSH Terminal"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_INSTALL}/usr/bin/ttyd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -p $(get_install_dir json-c)/usr/lib/libjson-c.so.5 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -p $(get_install_dir libwebsockets)/usr/lib/libwebsockets.so.20 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -p $(get_install_dir libwebsockets)/usr/lib/libwebsockets-evlib_uv.so ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -p $(get_install_dir libuv)/usr/lib/libuv.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
}
