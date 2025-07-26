# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usbmuxd"
PKG_VERSION="523f7004dce885fe38b4f80e34a8f76dc8ea98b5"
PKG_SHA256="a51615bb17bcf04ea4caac1edc58227a006a37b940878d3466b56a73b8b37af0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="https://github.com/libimobiledevice/usbmuxd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb libimobiledevice libimobiledevice-glue libusbmuxd libplist"
PKG_TOOLCHAIN="autotools"
PKG_SECTION="service"
PKG_SHORTDESC="USB Multiplex Daemon"
PKG_LONGDESC="USB Multiplex Daemon"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="iPhone Tether"
PKG_ADDON_TYPE="xbmc.service"

PKG_DISCLAIMER="Additional data charges may occur. The LibreELEC team doesn't take any resposibility for extra data charges."

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"

configure_package() {
  # if using a git hash as a package version - set RELEASE_VERSION
  if [ -f ${PKG_BUILD}/NEWS ]; then
    export RELEASE_VERSION="$(sed -n '1,/RE/s/Version \(.*\)/\1/p' ${PKG_BUILD}/NEWS)-git-${PKG_VERSION:0:7}"
  fi
}

post_configure_target() {
  libtool_remove_rpath libtool
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_BUILD}/.${TARGET_NAME}/src/usbmuxd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
}
