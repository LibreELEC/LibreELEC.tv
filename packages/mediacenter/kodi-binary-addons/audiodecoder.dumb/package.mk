# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.dumb"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="c233d538afdc390c539ea7a969ba029ce10efe0904aefcb5a8a08393638f76b1"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audiodecoder.dumb"
PKG_URL="https://github.com/xbmc/audiodecoder.dumb/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.dumb"
PKG_LONGDESC="audiodecoder.dumb"
PKG_BUILD_FLAGS="pic"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
