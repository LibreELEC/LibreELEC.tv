# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.fluidsynth"
PKG_VERSION="20.2.3-Nexus"
PKG_SHA256="7b7f2c131c5c50be8df72cb3ae0b5bd02f571f9c73e1d008304fc6a9e89c87a3"
PKG_REV="37"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audiodecoder.fluidsynth"
PKG_URL="https://github.com/xbmc/audiodecoder.fluidsynth/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host fluidsynth"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.fluidsynth"
PKG_LONGDESC="audiodecoder.fluidsynth"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
