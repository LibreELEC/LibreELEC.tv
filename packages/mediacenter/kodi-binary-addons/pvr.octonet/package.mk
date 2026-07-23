# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.octonet"
PKG_VERSION="22.2.1-Piers"
PKG_SHA256="f2ba368d6066198691ca1b5d53bf94ba2288dadc2051ecb5be9013e9ca9a9012"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/DigitalDevices/pvr.octonet"
PKG_URL="https://github.com/DigitalDevices/pvr.octonet/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="A pvr plugin for DigitalDevices Octonet Sat>IP servers"
PKG_LONGDESC="A pvr plugin for DigitalDevices Octonet Sat>IP servers"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
