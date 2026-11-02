# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.waipu"
PKG_VERSION="22.10.4-Piers"
PKG_SHA256="0ed514daf78e805c02517f3c9a7c732d235ab7b0f9897e82d68b384cba724154"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/flubshi/pvr.waipu"
PKG_URL="https://github.com/flubshi/pvr.waipu/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json"
PKG_SECTION=""
PKG_SHORTDESC="pvr.waipu"
PKG_LONGDESC="pvr.waipu"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
