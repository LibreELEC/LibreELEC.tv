# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mc"
PKG_VERSION="4.8.33"
PKG_SHA256="cae149d42f844e5185d8c81d7db3913a8fa214c65f852200a9d896b468af164c"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org"
PKG_URL="http://ftp.midnight-commander.org/mc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gettext:host glib libssh2 libtool:host ncurses pcre2"
PKG_LONGDESC="Midnight Commander is a text based filemanager that emulates Norton Commander."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET=" \
  --datadir=/storage/.kodi/addons/virtual.system-tools/data \
  --libexecdir=/storage/.kodi/addons/virtual.system-tools/mclib \
  --sysconfdir=/storage/.kodi/addons/virtual.system-tools/etc \
  --with-screen=ncurses \
  --with-sysroot=${SYSROOT_PREFIX} \
  --disable-aspell \
  --without-diff-viewer \
  --disable-doxygen-doc \
  --disable-doxygen-dot \
  --disable-doxygen-html \
  --with-gnu-ld \
  --without-libiconv-prefix \
  --without-libintl-prefix \
  --with-internal-edit \
  --disable-mclib \
  --with-subshell \
  --enable-vfs-extfs \
  --enable-vfs-ftp \
  --enable-vfs-sftp \
  --enable-vfs-tar \
  --with-search-engine=pcre2 \
  --with-pcre2=${SYSROOT_PREFIX}/usr \
  --without-x"

pre_configure_target() {
  LDFLAGS+=" -lcrypto -lssl"
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/storage/.kodi/addons/virtual.system-tools/data/locale
  rm -rf ${INSTALL}/storage/.kodi/addons/virtual.system-tools/data/mc/help/mc.hlp.*
  mv ${INSTALL}/usr/bin/mc ${INSTALL}/usr/bin/mc-bin
  rm -f ${INSTALL}/usr/bin/{mcedit,mcview}
  cp -p ${PKG_DIR}/wrapper/* ${INSTALL}/usr/bin
}
