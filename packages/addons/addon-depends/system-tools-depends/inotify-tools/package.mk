# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inotify-tools"
PKG_VERSION="4.26.291"
PKG_SHA256="633c012d30a0f66770454ee15e6d5d24003a61206b4a698cc4b32e6715855667"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/inotify-tools/inotify-tools"
PKG_URL="https://github.com/inotify-tools/inotify-tools/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="A library and a set of command-line programs for Linux providing a simple interface to inotify."
PKG_TOOLCHAIN="manual"

make_target() {
  cargo build \
    --target ${TARGET_NAME} \
    --release \
    --locked \
    --package inotify-tools \
    --bins
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/{inotifywait,inotifywatch} ${INSTALL}/usr/bin
}
