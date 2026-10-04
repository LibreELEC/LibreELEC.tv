# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.njoy"
PKG_VERSION="22.2.4-Piers"
PKG_SHA256="3ec3c7d931eeafae79c0de45e3aa0bbcc8f3c7c5c5ea1ca9a521ea4996a83066"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.njoy"
PKG_URL="https://github.com/kodi-pvr/pvr.njoy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="pvr.njoy"
PKG_LONGDESC="pvr.njoy"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
