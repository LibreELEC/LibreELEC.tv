# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="misc-firmware"
PKG_VERSION="a7ba8d5ebf53c26ad4382d5eade58ec1a5105688"
PKG_SHA256="bb1141b30f8091894fa3e3df4bec6974378600f3e0a614aa8b11749eb2591b3f"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/LibreELEC/misc-firmware"
PKG_URL="https://github.com/LibreELEC/misc-firmware/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kernel-firmware"
PKG_LONGDESC="misc-firmware: firmwares for various drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir) ./install
}
