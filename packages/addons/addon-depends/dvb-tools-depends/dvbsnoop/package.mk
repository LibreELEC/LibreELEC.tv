# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvbsnoop"
PKG_VERSION="72a64d59b6b00272fbfbeebdc9da9d6e8ace67da" # 2021-12-12
PKG_SHA256="7364c04b05e3ce311c14544fd01ca8ad846f4cfab5951815bdec64fe6cc35a0c"
PKG_LICENSE="GPL"
PKG_SITE="http://dvbsnoop.sourceforge.net/"
PKG_URL="https://github.com/Duckbox-Developers/dvbsnoop/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dvbsnoop is a DVB/MPEG stream analyzer program"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"
