# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mumudvb"
PKG_VERSION="46056b21f790603dfb38ca5c39be84c92f32d99e"
PKG_SHA256="e904348a36c10a3930384b55a4a31250780456306c9c98cedbdcee277afea3e9"
PKG_LICENSE="GPL"
PKG_SITE="http://mumudvb.net/"
PKG_URL="https://github.com/braice/MuMuDVB/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvbcsa gettext"
PKG_LONGDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"
