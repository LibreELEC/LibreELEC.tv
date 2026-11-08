# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="automake"
PKG_VERSION="1.20"
PKG_SHA256="f6f34dad4cbe395715762b0710f7c511e39bd5cf777e6b95818ccbecf7714248"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://sources.redhat.com/automake/"
PKG_URL="https://ftp.gnu.org/gnu/automake/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host autoconf:host"
PKG_LONGDESC="A GNU tool for automatically creating Makefiles."
PKG_BUILD_FLAGS="-parallel -cfg-libs:host"

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} --disable-silent-rules"

post_makeinstall_host() {
  make prefix=${SYSROOT_PREFIX}/usr install
}
