# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmtp"
PKG_VERSION="1.1.22"
PKG_SHA256="c3fcf411aea9cb9643590cbc9df99fa5fe30adcac695024442973d76fa5f87bc"
PKG_LICENSE="GPL"
PKG_SITE="http://libmtp.sourceforge.net/"
PKG_URL="${SOURCEFORGE_SRC}/project/${PKG_NAME}/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb gettext"
PKG_LONGDESC="An Initiator implementation of the Media Transfer Protocol (MTP)."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           --disable-shared \
                           --enable-static \
                           --enable-crossbuilddir \
                           --disable-mtpz"

pre_configure_target() {
  # override mtp-hotplug with true as the built files are not used.
  # the generated udev files are deleted is the post_makeinstall_target.
  export HOST_MTP_HOTPLUG="/usr/bin/true"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/lib/udev/hwdb.d
  safe_remove ${INSTALL}/usr/lib/udev/rules.d
}
