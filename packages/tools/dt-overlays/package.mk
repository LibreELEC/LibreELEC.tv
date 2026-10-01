# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dt-overlays"
PKG_VERSION="3668156f36bf9409ccad0f82014e8b48d257c620"
PKG_SHA256="42a0708a26af8526e8a93dc43478cf040c4be3f2b28fa7b2794478ef1fd2d1d5"
PKG_LICENSE="GPL-2.0-or-later OR MIT"
PKG_SITE="https://github.com/LibreELEC/dt-overlays"
PKG_URL="https://github.com/LibreELEC/dt-overlays/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="dtc:host"
PKG_LONGDESC="The Device Tree Overlays"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/overlays
    cp -p overlays/*/*.dtbo ${INSTALL}/usr/share/bootloader/overlays
}
