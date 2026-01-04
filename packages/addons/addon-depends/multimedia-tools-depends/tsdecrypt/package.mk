# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tsdecrypt"
PKG_VERSION="f4876e84cf1866645f84b93f830af67193c85f69"
PKG_SHA256="084704d2b121f0fbbe5e5960bb50fbc11695b1cfcd65ebab24b1bf58cfebb38f"
PKG_LICENSE="GPL"
PKG_SITE="https://georgi.unixsol.org/programs/tsdecrypt/"
PKG_URL="https://github.com/gfto/tsdecrypt/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvbcsa openssl"
PKG_DEPENDS_UNPACK="libfuncs libtsfuncs"
PKG_LONGDESC="A tool that reads incoming mpeg transport stream over UDP/RTP and then decrypts it using libdvbcsa/ffdecsa."
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

post_unpack() {
  tar --strip-components=1 \
    -xf "${SOURCES}/libfuncs/libfuncs-$(get_pkg_version libfuncs).tar.gz" \
    -C "${PKG_BUILD}/libfuncs"
  tar --strip-components=1 \
    -xf "${SOURCES}/libtsfuncs/libtsfuncs-$(get_pkg_version libtsfuncs).tar.gz" \
    -C "${PKG_BUILD}/libtsfuncs"
}

make_target() {
  make TARGET=${TARGET_PREFIX} CC=gcc LINK="ld -o"
}

post_make_target() {
  make strip STRIP=${STRIP}
}
