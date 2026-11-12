# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usb-modeswitch"
PKG_VERSION="2.6.3"
PKG_SHA256="cddb987af80eca5bc9c364dc0ccd0e2b788de4d28626d017277a48c06b0453b6"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://www.draisberghof.de/usb_modeswitch/"
PKG_URL="https://www.draisberghof.de/usb_modeswitch/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="USB_ModeSwitch - Handling Mode-Switching USB Devices on Linux"
PKG_BUILD_FLAGS="-sysroot"
