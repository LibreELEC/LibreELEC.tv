# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.sledovanitv.cz"
PKG_VERSION="22.7.0-Piers"
PKG_SHA256="9a3df83b2905bf216cf8ecb3f7cbd5e5deaf7af2c998b45f83545ffdb6771983"
PKG_REV="2"
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
