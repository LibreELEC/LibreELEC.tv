# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vfs.sftp"
PKG_VERSION="22.0.6-Piers"
PKG_SHA256="e0d54427f74874da2352afdea0288864dbaf8dc38ecc5bbc0b1711a129233e0c"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/vfs.sftp"
PKG_URL="https://github.com/xbmc/vfs.sftp/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libssh"
PKG_SECTION=""
PKG_SHORTDESC="vfs.sftp"
PKG_LONGDESC="vfs.sftp"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.vfs"
