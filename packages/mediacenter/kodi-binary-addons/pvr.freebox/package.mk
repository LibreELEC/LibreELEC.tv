# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.freebox"
PKG_VERSION="22.2.2-Piers"
PKG_SHA256="eb002075d7fa65ad486d120c1a56f8d6cad7c85c93f05058c9e5e8ad24da9df0"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/aassif/pvr.freebox"
PKG_URL="https://github.com/aassif/pvr.freebox/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json openssl zlib"
PKG_SECTION=""
PKG_SHORTDESC="pvr.freebox"
PKG_LONGDESC="pvr.freebox"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
