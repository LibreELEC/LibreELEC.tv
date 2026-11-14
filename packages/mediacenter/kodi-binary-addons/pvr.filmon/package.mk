# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.filmon"
PKG_VERSION="22.2.5-Piers"
PKG_SHA256="4003e6c76c0e3b08becfdfa66606d2c8d56c6e89a713c32226c5216ed69e407b"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.filmon"
PKG_URL="https://github.com/kodi-pvr/pvr.filmon/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="pvr.filmon"
PKG_LONGDESC="pvr.filmon"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
