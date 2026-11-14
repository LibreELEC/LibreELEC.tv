# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.wmc"
PKG_VERSION="22.2.5-Piers"
PKG_SHA256="f5905bee24f0ed43aa18c4a9b20a88af6dcf352d95fc3ee80371c5b8ffa6f911"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.wmc"
PKG_URL="https://github.com/kodi-pvr/pvr.wmc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="pvr.wmc"
PKG_LONGDESC="pvr.wmc"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
