# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vfs.pdf"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="a8827d4b109dbb9850dbd2c096f57a8726d39c373f5099c2928d1911575f8074"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/vfs.pdf"
PKG_URL="https://github.com/xbmc/vfs.pdf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ${MEDIACENTER}:host poppler libjpeg-turbo"
PKG_SECTION=""
PKG_SHORTDESC="vfs.pdf"
PKG_LONGDESC="Opens a PDF as a folder of page pictures, so game manuals can be read in Kodi."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.vfs"
