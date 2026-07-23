# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.vuplus"
PKG_VERSION="22.3.6-Piers"
PKG_SHA256="344edd84930843f79bd40a2b3f773344abe4e20f9d8aec0dd5fe1efc5881416b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-pvr/pvr.vuplus"
PKG_URL="https://github.com/kodi-pvr/pvr.vuplus/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host nlohmann-json"
PKG_SECTION=""
PKG_SHORTDESC="pvr.vuplus"
PKG_LONGDESC="pvr.vuplus"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"
