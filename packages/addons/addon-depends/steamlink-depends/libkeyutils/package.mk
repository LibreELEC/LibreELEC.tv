# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libkeyutils"
PKG_VERSION="1.6.3"
PKG_SHA256=""
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git"
PKG_URL="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/snapshot/keyutils-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Tools used to control the key management system built into the Linux kernel."
PKG_BUILD_FLAGS="-sysroot"
PKG_TOOLCHAIN="manual"

make_target() {
  NO_ARLIB=1 make
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
    cp -p libkeyutils.so.1.10 ${INSTALL}/usr/lib/
    ln -s ${INSTALL}/usr/lib/libkeyutils.so.1.10 ${INSTALL}/usr/lib/libkeyutils.so.1
}
