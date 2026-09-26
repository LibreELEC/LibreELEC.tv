# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cifs-utils"
PKG_VERSION="7.8"
PKG_SHA256="b5321d3ff848d361c129aeec4ec8431642582b7036cb8a2a403667d5909d4172"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://wiki.samba.org/index.php/LinuxCIFS_utils"
PKG_URL="https://download.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain talloc"
PKG_LONGDESC="Linux CIFS userspace utilities"
PKG_BUILD_FLAGS="-cfg-libs"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --disable-cifsupcall \
                           --disable-cifscreds \
                           --disable-cifsidmap \
                           --disable-cifsacl \
                           --disable-smbinfo \
                           --disable-pythontools \
                           --disable-pam \
                           --disable-man \
                           --disable-systemd"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/sbin/"
    cp -PR mount.cifs "${INSTALL}/usr/sbin/"
    ln -s mount.cifs "${INSTALL}/usr/sbin/mount.smb3"
}
