# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="w_scan2"
PKG_VERSION="1.0.17"
PKG_SHA256="0abf68dc7247eb3a5a3327604f888f18243c57f4abd04d011c1502abdee37ddf"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/stefantalpalaru/w_scan2"
PKG_URL="https://github.com/stefantalpalaru/w_scan2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A channel scan tool which generates ATSC, DVB-C, DVB-S/S2 and DVB-T channels.conf files."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"
