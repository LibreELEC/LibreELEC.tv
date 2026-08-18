# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cachefilesd"
PKG_VERSION="0.10.10"
PKG_SHA256="71d9eab41a7350c7adeb79e68c5112e72457120b8246735f829f0f6ba5a4803c"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachefilesd.git/"
PKG_URL="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachefilesd.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Daemon that manages the on-disk cache used by the kernel fscache layer, e.g. for NFS and CIFS mounts made with the 'fsc' option."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+size"

make_target() {
  # the makefile hardcodes CFLAGS and appends -m32/-m64 based on the build
  # host, so pass the target flags on the command line to override it
  make CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    cp cachefilesd ${INSTALL}/usr/sbin

  # userconfig-setup copies this to /storage/.config on first boot, where it
  # stays user-editable and survives updates
  mkdir -p ${INSTALL}/usr/config
    cp ${PKG_DIR}/config/cachefilesd.conf ${INSTALL}/usr/config
}

post_install() {
  enable_service cachefilesd.service
}
