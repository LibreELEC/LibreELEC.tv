# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.teleboy"
PKG_VERSION="22.2.2-Piers"
PKG_SHA256="b4e2472ea985f7583a5aad3718aaf1fb65d409a7ddb238fd85bb3fa396d29179"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/rbuehlma/pvr.teleboy"
PKG_URL="https://github.com/rbuehlma/pvr.teleboy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json sqlite"
PKG_SECTION=""
PKG_SHORTDESC="pvr.teleboy"
PKG_LONGDESC="pvr.teleboy"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
