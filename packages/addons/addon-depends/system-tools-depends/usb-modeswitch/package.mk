# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usb-modeswitch"
PKG_VERSION="2.6.2"
PKG_SHA256="f7abd337784a9d1bd39cb8a587518aff6f2a43d916145eafd80b1b8b7146db66"
PKG_LICENSE="GPL"
PKG_SITE="http://www.draisberghof.de/usb_modeswitch/"
PKG_URL="http://www.draisberghof.de/usb_modeswitch/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="USB_ModeSwitch - Handling Mode-Switching USB Devices on Linux"
PKG_BUILD_FLAGS="-sysroot"
