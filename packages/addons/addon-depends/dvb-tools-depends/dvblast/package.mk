# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvblast"
PKG_VERSION="74b297310be8def45d8c890c19a88fff3b1bbeb9" # HEAD 29/07/2025
PKG_SHA256="6c29ff62bdaf08eb0850acbd71b49345ec33a5b87ec7d9c0749b92a1ddbb0084"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/projects/dvblast.html"
PKG_URL="https://code.videolan.org/videolan/dvblast/-/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_LONGDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -lm"
  export PREFIX="/usr"
}
