# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.sledovanitv.cz"
PKG_VERSION="22.7.1-Piers"
PKG_SHA256="1aa686ca4fc979590b100fa4dc8b14e5b1ad0c64b63634971b8ba018e6eea99a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/palinek/pvr.sledovanitv.cz"
PKG_URL="https://github.com/palinek/pvr.sledovanitv.cz/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host jsoncpp nlohmann-json"
PKG_SECTION=""
PKG_SHORTDESC="pvr.sledovanitv.cz"
PKG_LONGDESC="pvr.sledovanitv.cz"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
