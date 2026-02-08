# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.4.8"
PKG_SHA256="ced7e5063c91fe2bfafd9d63a759490fe53e81df80599a9abad01c570c202f0c"
PKG_LICENSE="LGPL"
PKG_SITE="https://mariadb.org/"
PKG_URL="https://github.com/mariadb-corporation/mariadb-connector-c/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="mariadb-connector: library to connect to mariadb/mysql database server"
PKG_BUILD_FLAGS="-gold"

PKG_CMAKE_OPTS_TARGET="-DWITH_EXTERNAL_ZLIB=ON
                       -DWITH_UNIT_TESTS=OFF
                       -DCLIENT_PLUGIN_DIALOG=STATIC
                       -DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
                       -DCLIENT_PLUGIN_MYSQL_OLD_PASSWORD=STATIC
                       -DCLIENT_PLUGIN_REMOTE_IO=OFF
                       -DDEFAULT_SSL_VERIFY_SERVER_CERT=OFF
                      "

pre_configure_target() {
  export CFLAGS+=" -Wno-discarded-qualifiers"
}

post_makeinstall_target() {
  # keep mariadb shared library and modern authentication plugins
  LIBDIR=${INSTALL}/usr/lib
  mkdir -p ${INSTALL}/.tmp/mariadb/plugin
  mv ${LIBDIR}/mariadb/libmariadb.so* ${INSTALL}/.tmp
  mv ${LIBDIR}/mariadb/plugin/{caching_sha2_password,client_ed25519,sha256_password}.so ${INSTALL}/.tmp/mariadb/plugin

  # drop all unneeded
  rm -rf ${INSTALL}/usr

  mkdir -p ${LIBDIR}
  mv ${INSTALL}/.tmp/* ${LIBDIR}/
  rmdir ${INSTALL}/.tmp
}
