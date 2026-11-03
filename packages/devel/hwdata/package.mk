# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hwdata"
PKG_VERSION="0.413"
PKG_SHA256="5a71ab7a48c668ef912fcfdbec046949087019f8dd7fb967445d36fbeb778350"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/vcrhonek/hwdata"
PKG_URL="https://github.com/vcrhonek/hwdata/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="hwdata contains various hardware identification and configuration data, such as the pci.ids and usb.ids databases"

configure_host() {
  # hwdata fails to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}

  ./configure --prefix=${TOOLCHAIN} --libexecdir=${TOOLCHAIN}/lib
}
