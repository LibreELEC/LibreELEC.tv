# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="krb5"
PKG_VERSION="1.22.3"
PKG_SHA256="fe90af8441ad9fa9b064b8e53077cefb782a96f8a68276b031dc54af1789ff0b"
PKG_LICENSE="MIT"
PKG_SITE="https://web.mit.edu/kerberos/"
# XXX bump on major version change
PKG_URL="https://kerberos.org/dist/krb5/1.22/krb5-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Kerberos is a network authentication protocol. It is designed to provide strong authentication for client/server applications by using secret-key cryptography."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="krb5_cv_attr_constructor_destructor=yes,yes \
                           ac_cv_func_regcomp=yes \
                           ac_cv_printf_positional=yes"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=2 -xf ${SOURCES}/krb5/krb5-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}
