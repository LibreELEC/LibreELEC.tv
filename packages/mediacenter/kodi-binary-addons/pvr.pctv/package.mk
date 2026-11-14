# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.pctv"
PKG_VERSION="22.2.5-Piers"
PKG_SHA256="4f13cdb0092f3e1b979058d6a5594ef14138c906a539881f025242165c54e601"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.pctv"
PKG_URL="https://github.com/kodi-pvr/pvr.pctv/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="pvr.pctv"
PKG_LONGDESC="pvr.pctv"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
