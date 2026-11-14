# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.sacd"
PKG_VERSION="22.0.6-Piers"
PKG_SHA256="53eb9d2f19762724ee96981797f7d21b4dfa58e139ece92a09d30033ea92836b"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audiodecoder.sacd"
PKG_URL="https://github.com/xbmc/audiodecoder.sacd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host wavpack"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.sacd"
PKG_LONGDESC="audiodecoder.sacd"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
