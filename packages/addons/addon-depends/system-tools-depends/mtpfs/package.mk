# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtpfs"
PKG_VERSION="1177d6cfd8916915f5db7d9b5c6fc9e6eafae6e6"
PKG_SHA256="ed8101e05d668ba7fa13517ab5d6e4cee1097cf68206ff1c84d13433ca4192a5"
PKG_LICENSE="GPL"
PKG_SITE="https://www.adebenham.com/mtpfs/"
PKG_URL="https://github.com/cjd/mtpfs/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse glib libmtp"
PKG_LONGDESC="MTPfs is a FUSE filesystem that supports reading and writing from any MTP device."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-mad"

# TODO: mtpfs runs host utils while building, fix and set
pre_configure_target() {
  export LIBS="-lusb-1.0 -ludev"
  TARGET_CONFIGURE_OPTS=$(echo ${TARGET_CONFIGURE_OPTS} | sed -e "s|--disable-static||" -e "s|--enable-shared||")
}
