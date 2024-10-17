# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sshpass"
PKG_VERSION="1.10"
PKG_SHA256="ad1106c203cbb56185ca3bad8c6ccafca3b4064696194da879f81c8d7bdfeeda"
PKG_LICENSE="GPLv2"
PKG_SITE="https://sourceforge.net/p/sshpass"
PKG_URL="https://downloads.sourceforge.net/sshpass/sshpass-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="sshpass: a tool for non-interactive ssh password auth"
PKG_BUILD_FLAGS="-cfg-libs"

pre_configure_target() {
  export ac_cv_func_malloc_0_nonnull=yes
  export ac_cv_func_realloc_0_nonnull=yes
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp sshpass ${INSTALL}/usr/bin
}
