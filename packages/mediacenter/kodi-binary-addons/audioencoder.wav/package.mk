# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audioencoder.wav"
PKG_VERSION="22.0.3-Piers"
PKG_SHA256="8ca6b38660815593adb8c276347a51cbb91138d42de7f05bb2abda37624e3638"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audioencoder.wav"
PKG_URL="https://github.com/xbmc/audioencoder.wav/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="audioencoder.wav: A audioencoder addon for Kodi"
PKG_LONGDESC="audioencoder.wav is a audioencoder addon for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.audioencoder"
