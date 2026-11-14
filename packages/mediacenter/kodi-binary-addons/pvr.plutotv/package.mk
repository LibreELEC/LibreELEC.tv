# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.plutotv"
PKG_VERSION="22.3.2-Piers"
PKG_SHA256="a56bbd15ea5eca3143feba281fa6f0f6dfc42ebed37e886d7ddd18013cae4f8e"
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
