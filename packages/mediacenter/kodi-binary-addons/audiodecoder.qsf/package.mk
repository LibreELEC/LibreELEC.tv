# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.qsf"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="b15e4c3dc7a166b1703c2781beb1103e3734f10ec4d6119385563ec19906035e"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audiodecoder.qsf"
PKG_URL="https://github.com/xbmc/audiodecoder.qsf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.qsf"
PKG_LONGDESC="audiodecoder.qsf"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
