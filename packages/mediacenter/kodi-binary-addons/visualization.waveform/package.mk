# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.waveform"
PKG_VERSION="22.1.0-Piers"
PKG_SHA256="f7af7881fc13ca6cf91f9a1ff942b0ee1359cec5b6c4df5fcdb1967eff94150c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/visualization.waveform"
PKG_URL="https://github.com/xbmc/visualization.waveform/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="visualization.waveform"
PKG_LONGDESC="visualization.waveform"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"
