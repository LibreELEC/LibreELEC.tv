# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="terminal.foot"
PKG_VERSION="0.0.1"
PKG_REV="0"
PKG_LICENSE="MIT"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain foot"
PKG_SECTION="tools"
PKG_SHORTDESC="A Wayland terminal emulator"
PKG_LONGDESC="A Wayland terminal emulator"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Terminal (Foot)"
PKG_ADDON_ICON_NAME="FOOT"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_REQUIRES="tools.externalhelper:0.0.0"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir foot)/usr/bin/foot "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    patchelf --add-rpath '${ORIGIN}/../lib.private' "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/foot"

  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir wayland)/usr/lib/libwayland-{client,cursor}.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

  cp -P $(get_install_dir foot)/etc/xdg/foot/foot.ini "${ADDON_BUILD}/${PKG_ADDON_ID}"
}
