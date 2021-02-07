# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2012 Yann Cézard (eesprit@free.fr)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="open-iscsi"
PKG_VERSION="2.1.3"
PKG_SHA256="5410474b23552016220d04aa181903cb50ae988f29e99cb03f3e2de86a109be4"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/open-iscsi/open-iscsi"
PKG_URL="https://github.com/open-iscsi/open-iscsi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_INIT="toolchain util-linux open-isns systemd"
PKG_LONGDESC="The open-iscsi package allows you to mount iSCSI targets."

PKG_MAKE_OPTS_INIT="user"

pre_configure_init() {
  export OPTFLAGS="${CFLAGS} ${LDFLAGS}"
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/usr/iscsistart ${INSTALL}/usr/sbin
  mkdir -p ${INSTALL}/usr/lib
    cp -P ${PKG_BUILD}/libopeniscsiusr/libopeniscsiusr.so.0.2.0 ${INSTALL}/usr/lib
    ln -sf libopeniscsiusr.so.0.2.0 ${INSTALL}/usr/lib/libopeniscsiusr.so
    ln -sf libopeniscsiusr.so.0.2.0 ${INSTALL}/usr/lib/libopeniscsiusr.so.0
}
