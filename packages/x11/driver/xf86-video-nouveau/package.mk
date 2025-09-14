# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-nouveau"
PKG_VERSION="1.0.18"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_DEPENDS_TARGET="toolchain util-macros xorg-server"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=${XORG_PATH_MODULES}"
