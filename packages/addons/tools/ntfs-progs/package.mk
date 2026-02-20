# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfs-progs"
PKG_REV="1"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain fuse ntfs-3g_ntfsprogs"
PKG_SECTION="tools"
PKG_SHORTDESC="ntfs-3g tools for the NTFS filesystem"
PKG_LONGDESC="ntfs-3g tools for the NTFS filesystem: mkntfs, ntfslabel and ntfsresize"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="NTFS Tools"
PKG_ADDON_TYPE="xbmc.python.script"

addon() {
  PKG_NTFS_INSTALL=$(get_install_dir ntfs-3g_ntfsprogs)
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
    cp -P ${PKG_NTFS_INSTALL}/.noinstall/{mkntfs,ntfslabel,ntfsresize} \
      ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
