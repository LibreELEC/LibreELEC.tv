# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtpfs"
PKG_VERSION="2bd9b5a33ad70a2238e086ffb07907f20a1e0101"
PKG_SHA256="732d5d450cfefd9df0e53ed6b188e1428298d8f81aaa8b5bf24ad31b9fddbe8f"
PKG_LICENSE="GPL"
PKG_SITE="https://www.adebenham.com/mtpfs/"
PKG_URL="https://github.com/cjd/mtpfs/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse glib libmtp"
PKG_LONGDESC="MTPfs is a FUSE filesystem that supports reading and writing from any MTP device."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--disable-mad"

# TODO: mtpfs runs host utils while building, fix and set
pre_configure_target() {
  export LIBS="-lusb-1.0 -ludev"
}
