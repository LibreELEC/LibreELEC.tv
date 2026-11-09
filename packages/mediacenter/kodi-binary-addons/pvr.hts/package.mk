# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.hts"
PKG_VERSION="22.9.7-Piers"
PKG_SHA256="a64a96489c9a11a451889d20307b559f6c9d5444f13482110bc9b725932cbf3f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.hts"
PKG_URL="https://github.com/kodi-pvr/pvr.hts/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="pvr.hts"
PKG_LONGDESC="pvr.hts"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
