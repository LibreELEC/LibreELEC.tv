# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libreelecupdate"
PKG_VERSION="5ed2093d5e20f45f2f7d561413e7811c0cbe3f4b"
PKG_SHA256="4fe47406a96b435612632989ea4aa4cf1f18fde51521ac3c8f899d978a049472"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/antonlacon/libreelecupdate"
PKG_URL="https://github.com/antonlacon/libreelecupdate/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Python library and command line client to install version updates for LibreELEC"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -PRv client_update.py ${INSTALL}/usr/bin
    chmod +x ${INSTALL}/usr/bin/*
  mkdir -p ${INSTALL}/usr/lib/libreelec/
    cp -PRv update_lib.py ${INSTALL}/usr/lib/libreelec
}
