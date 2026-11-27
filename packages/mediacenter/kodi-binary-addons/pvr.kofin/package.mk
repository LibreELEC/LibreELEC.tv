# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.kofin"
PKG_VERSION="22.20.1-Piers"
PKG_SHA256="f3c5320312b3d4cd8318465a6afd654507d2acf0a86bb99c21eec2ef5f0707b4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.kofin"
PKG_URL="https://github.com/kodi-pvr/pvr.kofin/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ${MEDIACENTER}:host jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="pvr.kofin"
PKG_LONGDESC="pvr.kofin"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
