# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.plutotv"
PKG_VERSION="22.3.1-Piers"
PKG_SHA256="d2b99876fbfa5b9a5e97abde467d9c6f8d07e4809013132562cf67b90963f0fd"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.plutotv"
PKG_URL="https://github.com/kodi-pvr/pvr.plutotv/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json"
PKG_SECTION=""
PKG_SHORTDESC="pvr.plutotv"
PKG_LONGDESC="pvr.plutotv"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
