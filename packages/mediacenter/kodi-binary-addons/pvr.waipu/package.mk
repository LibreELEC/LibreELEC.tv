# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.waipu"
PKG_VERSION="22.10.0-Piers"
PKG_SHA256="9e7e71df13dd3f6d01a8899ec2da794d7a5d0c080cd6fefc0279fccaf612a29b"
PKG_REV="2"
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
