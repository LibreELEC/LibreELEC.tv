# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lshw"
PKG_VERSION="02.20"
PKG_SHA256="06d9cf122422220e5dc94e8ea5b01816a69bb6b59368f63d7f21fff31fc6922a"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://project.ezix.org/wiki/HardwareLiSter"
PKG_URL="https://ezix.org/software/files/lshw-B.${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A small tool to provide detailed information on the hardware configuration of the machine."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  export VERSION="B.${PKG_VERSION}"
  make CXX=${CXX} -C src/
}
