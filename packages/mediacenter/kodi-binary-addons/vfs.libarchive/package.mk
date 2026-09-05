# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vfs.libarchive"
PKG_VERSION="22.0.2-Piers"
PKG_SHA256="ec9a9d0e1e362458f66fd42f1c2a54ca19b66244c4f64ab0b8ffa1181e1f9433"
PKG_REV="5"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/vfs.libarchive"
PKG_URL="https://github.com/xbmc/vfs.libarchive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host bzip2 libarchive lz4 lzo xz zlib"
PKG_SECTION=""
PKG_SHORTDESC="vfs.libarchive"
PKG_LONGDESC="vfs.libarchive"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.vfs"
