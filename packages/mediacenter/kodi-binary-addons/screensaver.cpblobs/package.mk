# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.cpblobs"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="c611deff379023ef3310f3a4eb75f0d1ae694310efa857fc79e35a178c751c01"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/screensaver.cpblobs"
PKG_URL="https://github.com/xbmc/screensaver.cpblobs/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host glm"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.cpblobs"
PKG_LONGDESC="screensaver.cpblobs"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi
