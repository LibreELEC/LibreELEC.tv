# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.zattoo"
PKG_VERSION="22.2.3-Piers"
PKG_SHA256="0fb9f133124efa1e19b38fb7748e371295ed2d74c38b1b0ba907321a927a0a60"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/rbuehlma/pvr.zattoo"
PKG_URL="https://github.com/rbuehlma/pvr.zattoo/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json sqlite tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="pvr.zattoo"
PKG_LONGDESC="pvr.zattoo"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
