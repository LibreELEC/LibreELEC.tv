# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tree"
PKG_VERSION="2.2.1"
PKG_SHA256="5caddcbca805131ff590b126d3218019882e4ca10bc9eb490bba51c05b9b3b75"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Old-Man-Programmer/tree"
PKG_URL="https://github.com/Old-Man-Programmer/tree/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Tree is utility for displaying a dictionary tree's contents including files, directories, and links."
PKG_TOOLCHAIN="manual"

make_target() {
  make tree CXX=${CXX} CC=${CC}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -p tree ${INSTALL}/usr/bin/
}
