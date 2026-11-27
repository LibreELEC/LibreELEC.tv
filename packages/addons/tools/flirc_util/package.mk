# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flirc_util"
PKG_VERSION="280cccbb333f5be30fc48ea958ca103d2fce6fec"
PKG_SHA256="fc0a79e2e08b96d6cb8d69a7ee3a0cec6445f690ff432dbe62945f583213940e"
PKG_REV="1"
PKG_LICENSE="LicenseRef-FLIRC"
PKG_SITE="http://www.flirc.tv"
PKG_URL="https://github.com/flirc/sdk/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain hidapi libusb"
PKG_SECTION="tools"
PKG_SHORTDESC="CLI utility for flirc IR receivers"
PKG_LONGDESC="Command-Line utility for configuring flirc IR receivers"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="flirc_util"
PKG_ADDON_ICON_NAME="FLIRC"
PKG_ADDON_ICON_SIZE="290"
PKG_ADDON_TYPE="xbmc.python.script"

make_target() {
  cd cli
  make VERBOSE="1" \
       CONFIG="release" \
       HOSTOS="LIBREELEC" \
       MACHINE="Linux_${TARGET_ARCH}" \
       BUILDDIR_ROOT="${PKG_BUILD}/build" \
       BUILDDIR="${PKG_BUILD}/build" \
       LSEARCH+=" -L../libs/Linux_${TARGET_ARCH}" \
       flirc_util
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private}
    cp -P ${PKG_BUILD}/build/flirc_util ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
    patchelf --add-rpath '${ORIGIN}/../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/flirc_util
    cp -P $(get_install_dir hidapi)/usr/lib/libhidapi-hidraw.so* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
}
