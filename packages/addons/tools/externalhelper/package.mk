# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="externalhelper"
PKG_VERSION="0"
PKG_REV="10"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain seatd wayland wlroots kanshi cage wayvnc"
PKG_SECTION="tools"
PKG_SHORTDESC="External programs helper"
PKG_LONGDESC="Tools to run external programs in a minimal wayland session"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="External programs helper"
PKG_ADDON_ICON_NAME="HELPER"
PKG_ADDON_ICON_SIZE="250"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir seatd)/usr/bin/{seatd,seatd-launch} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir cage)/usr/bin/cage "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir kanshi)/usr/bin/kanshi "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
	cp -P $(get_install_dir wayvnc)/usr/bin/wayvnc "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"

    for f in seatd seatd-launch cage kanshi wayvnc; do
      patchelf --add-rpath '${ORIGIN}/../lib.private' "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/${f}"
    done

  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir aml)/usr/lib/libaml.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
    cp -L $(get_install_dir jansson)/usr/lib/libjansson.so.4 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
    cp -L $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
    cp -L $(get_install_dir seatd)/usr/lib/libseat.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir wayland)/usr/lib/libwayland-{client,server}.so.0 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir wlroots)/usr/lib/libwlroots*.so "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    patchelf --add-rpath '${ORIGIN}/../lib.private' "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"libwlroots*.so
}
