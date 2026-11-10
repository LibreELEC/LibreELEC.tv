# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="amlogic-boot-fip"
PKG_LICENSE="LicenseRef-nonfree"
PKG_VERSION="b54e3bbbcf5613d451230d359d264844eeda7166"
PKG_SHA256="bf91f371193dba1d62d0f2d8dd3a815bbeecf24bcb1e42e50127ea9854597e86"
PKG_SITE="https://github.com/LibreELEC/amlogic-boot-fip"
PKG_URL="https://github.com/LibreELEC/amlogic-boot-fip/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="xxd:host"
PKG_LONGDESC="Firmware Image Package (FIP) sources used to sign Amlogic u-boot binaries in LibreELEC images"
PKG_TOOLCHAIN="manual"
PKG_STAMP="${UBOOT_SYSTEM}"

post_unpack() {
  # rename dirs for alta/solitude
  mv ${PKG_BUILD}/aml-a311d-cc ${PKG_BUILD}/alta
  mv ${PKG_BUILD}/aml-s905d3-cc ${PKG_BUILD}/solitude
}
