# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liblogging"
PKG_VERSION="1.0.8"
PKG_SHA256="6449b7bb75dc282ec6bf1b98a753c950746ea5b190ec9aee097881e4dc5c4bf1"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblogging.org"
PKG_URL="https://download.rsyslog.com/liblogging/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="An easy to use and lightweight signal-safe logging library."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-man-pages \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
