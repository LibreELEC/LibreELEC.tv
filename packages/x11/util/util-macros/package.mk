# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="util-macros"
PKG_VERSION="1.20.1"
PKG_SHA256="0b308f62dce78ac0f4d9de6888234bf170f276b64ac7c96e99779bb4319bcef5"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/util/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="X.org autoconf utilities such as M4 macros."
PKG_BUILD_FLAGS="-cfg-libs"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr
}
