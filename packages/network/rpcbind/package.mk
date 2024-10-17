# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpcbind"
PKG_VERSION="1.2.7"
PKG_SHA256="f6edf8cdf562aedd5d53b8bf93962d61623292bfc4d47eedd3f427d84d06f37e"
PKG_LICENSE="OSS"
PKG_SITE="http://rpcbind.sourceforge.net/"
PKG_URL="${SOURCEFORGE_SRC}/rpcbind/rpcbind/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libtirpc systemd"
PKG_LONGDESC="The rpcbind utility is a server that converts RPC program numbers into universal addresses."
PKG_BUILD_FLAGS="-cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_rpcsvc_mount_h=no \
                           --disable-warmstarts \
                           --disable-libwrap \
                           --enable-rmtcalls \
                           --with-statedir=/tmp \
                           --with-rpcuser=root"

post_install() {
  enable_service rpcbind.service
}
