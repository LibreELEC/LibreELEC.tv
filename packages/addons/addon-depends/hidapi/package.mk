# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hidapi"
PKG_VERSION="0.16.0"
PKG_SHA256="bc599d295792fe515778f19ce86a49760b0ea5fc114e5258245d470609632bbf"
PKG_LICENSE="LicenseRef-HIDAPI-orig"
PKG_SITE="http://libusb.info/"
PKG_URL="https://github.com/libusb/hidapi/archive/refs/tags/hidapi-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="HIDAPI is a multi-platform library which allows an application to interface with USB and Bluetooth HID-Class devices."
PKG_TOOLCHAIN="cmake"
