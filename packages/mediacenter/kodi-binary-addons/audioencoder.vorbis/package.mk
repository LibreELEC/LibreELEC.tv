# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audioencoder.vorbis"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="7409360a8b540303cd3f9e6b21a52e21dfcfe2f516f8a92a94b4035a90c5efb6"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audioencoder.vorbis"
PKG_URL="https://github.com/xbmc/audioencoder.vorbis/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libogg libvorbis"
PKG_SECTION=""
PKG_SHORTDESC="audioencoder.vorbis: A audioencoder addon for Kodi"
PKG_LONGDESC="audioencoder.vorbis is a audioencoder addon for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.audioencoder"
