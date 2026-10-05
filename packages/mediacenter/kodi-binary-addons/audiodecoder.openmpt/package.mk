# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.openmpt"
PKG_VERSION="22.0.4-Piers"
PKG_SHA256="ee00bedb54cf86c45de5c1cd0c6bf0a9ee8e6f69353a8bd119fe7e19e0f9997f"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audiodecoder.openmpt"
PKG_URL="https://github.com/xbmc/audiodecoder.openmpt/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libopenmpt"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.openmpt"
PKG_LONGDESC="audiodecoder.openmpt"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
