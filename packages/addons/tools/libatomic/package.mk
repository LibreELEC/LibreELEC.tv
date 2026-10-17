# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libatomic"
PKG_VERSION="1.0"
PKG_REV="0"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="gcc-libatomic"
PKG_SECTION="virtual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Libatomic"
PKG_ADDON_ICON_NAME="TOOLS"
PKG_ADDON_TYPE="xbmc.python.module"
PKG_SHORTDESC="The libatomic shared library"
PKG_LONGDESC="${PKG_ADDON_NAME} provides the libatomic shared library."

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/libs
    cp -PR $(get_install_dir gcc-libatomic)/usr/lib/* ${ADDON_BUILD}/${PKG_ADDON_ID}/libs/
}
