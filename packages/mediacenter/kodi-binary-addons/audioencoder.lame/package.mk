# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audioencoder.lame"
PKG_VERSION="22.0.2-Piers"
PKG_SHA256="848c64e827b6d34a7add06e0e96186faa2e8fed41e0807371e2aa2fdeea5c9d5"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/audioencoder.lame"
PKG_URL="https://github.com/xbmc/audioencoder.lame/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host lame"
PKG_SECTION=""
PKG_SHORTDESC="audioencoder.lame: A audioencoder addon for Kodi"
PKG_LONGDESC="audioencoder.lame is a audioencoder addon for Kodi"

# lame is a -sysroot package, so FindLame.cmake's bare find_library(mp3lame)
# cannot see it. Point the result variables at lame's install dir directly
# (lame is static-only, hence libmp3lame.a).
PKG_CMAKE_OPTS_TARGET="-DLAME_INCLUDE_DIRS=$(get_install_dir lame)/usr/include \
                       -DLAME_LIBRARIES=$(get_install_dir lame)/usr/lib/libmp3lame.a"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.audioencoder"
