# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.spectrum"
PKG_VERSION="22.1.1-Piers"
PKG_SHA256="dac63ce17984d48c8e20be136a840d2543cda184d12cf31c7839c8e810bcc537"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.spectrum"
PKG_URL="https://github.com/xbmc/visualization.spectrum/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.spectrum"
PKG_LONGDESC="visualization.spectrum"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"
