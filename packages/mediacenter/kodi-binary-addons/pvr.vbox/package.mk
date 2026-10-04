# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.vbox"
PKG_VERSION="22.2.5-Piers"
PKG_SHA256="ee82a2dd9e01b91c0c095555aa0e257fc2754349060250d636715452b7ca9e4a"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.vbox"
PKG_URL="https://github.com/kodi-pvr/pvr.vbox/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="pvr.vbox"
PKG_LONGDESC="pvr.vbox"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
