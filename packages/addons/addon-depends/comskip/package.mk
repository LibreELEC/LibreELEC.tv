# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="comskip"
PKG_VERSION="0b0785b320dc15a3cf497a7ed6731a930debee94"
PKG_SHA256="95d2a0f923baef6ecbec2eddb3ec33575b6a67f53856b7836fd030b99283be74"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://www.kaashoek.com/comskip/"
PKG_URL="https://github.com/erikkaashoek/Comskip/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain argtable2 ffmpegx lame"
PKG_DEPENDS_CONFIG="argtable2 ffmpegx"
PKG_LONGDESC="Comskip detects commercial breaks from a video stream. It can be used for post-processing recordings."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

pre_configure_target() {
  # lame is a -sysroot package, so ffmpegx's static libavcodec.a (which
  # pulls in libmp3lame symbols) can't be resolved without lame's
  # install path explicitly added here too.
  LDFLAGS+=" -L$(get_install_dir lame)/usr/lib"

  # pass ffmpegx to build
  CFLAGS+=" -I$(get_install_dir ffmpegx)/usr/local/include"
  LDFLAGS+=" -L$(get_install_dir ffmpegx)/usr/local/lib -ldl"
}
