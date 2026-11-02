# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pv"
PKG_VERSION="1.12.7"
PKG_SHA256="5326ed7ee95ef18039390c0b17891ac28985ac7c7a4235070fab767c1fe37bd8"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="http://www.ivarch.com/programs/pv.shtml"
PKG_URL="http://www.ivarch.com/programs/sources/pv-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Pipe Viewer can be inserted into any normal pipeline between two processes."
PKG_BUILD_FLAGS="-sysroot -cfg-libs"
