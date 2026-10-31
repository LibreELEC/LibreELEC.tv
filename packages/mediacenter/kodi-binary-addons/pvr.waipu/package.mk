# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.waipu"
PKG_VERSION="22.10.3-Piers"
PKG_SHA256="6d18747124ed3b6beee3f9e05755fec91cd9ced9b1c1a68509e9685557a530e7"
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
