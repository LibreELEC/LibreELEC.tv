# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pcsc-lite"
PKG_VERSION="2.3.3"
PKG_SHA256="cdff7d7153a0b37aa74e26dfec89ec7dc5c5286aa21b91b903e38739d227e8e7"
PKG_LICENSE="GPL"
PKG_SITE="https://pcsclite.apdu.fr"
PKG_URL="https://pcsclite.apdu.fr/files/pcsc-lite-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libusb polkit"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)."

PKG_MESON_OPTS_TARGET="-Ddefault_library=static \
                       -Dlibudev=false \
                       -Dlibusb=true \
                       -Dpolkit=true \
                       -Dusbdropdir=/storage/.kodi/addons/service.pcscd/drivers"

pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_install_dir polkit)/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
}
