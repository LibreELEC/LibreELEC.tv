# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="evtest"
PKG_VERSION="3fe3ce98d81ae8b00156933ddb86b92a874cba6a" # HEAD 07/04/2025
PKG_SHA256="ed9eace5cde4ce8d2c5bcfd10a700d2d0bbf843c1ed9359701db0305adb897ac"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.freedesktop.org/libevdev/evtest/"
PKG_URL="https://gitlab.freedesktop.org/libevdev/evtest/-/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libxml2"
PKG_LONGDESC="A simple tool for input event debugging."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"
