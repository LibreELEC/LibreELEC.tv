# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hwdata"
PKG_VERSION="0.396"
PKG_SHA256="6ed6ff6eb9d137b9669af6966974643a015cf302a39237ef84dd2efa5e20bae8"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/vcrhonek/hwdata"
PKG_URL="https://github.com/vcrhonek/hwdata/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="hwdata contains various hardware identification and configuration data, such as the pci.ids and usb.ids databases"

pre_configure_target() {
  # hwdata fails to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}

    sed -i "s&@prefix@|&@prefix@|${PKG_INSTALL}&" Makefile
    sed -i "s&prefix=@prefix@&prefix=/usr&" hwdata.pc.in
}
