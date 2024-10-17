# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsync"
PKG_VERSION="3.3.0"
PKG_SHA256="7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90"
PKG_LICENSE="GPLv3"
PKG_SITE="https://rsync.samba.org"
PKG_URL="https://download.samba.org/pub/rsync/src/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="A very fast method for bringing remote files into sync."
PKG_BUILD_FLAGS="-sysroot -cfg-libs -cfg-libs:host"

PKG_CONFIGURE_OPTS_HOST="--disable-md2man \
                         --disable-ipv6 \
                         --disable-openssl \
                         --disable-xxhash \
                         --disable-zstd \
                         --disable-lz4 \
                         --disable-iconv \
                         --with-included-popt \
                         --without-included-zlib"

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-md5-asm \
                           --enable-openssl \
                           --disable-lz4 \
                           --disable-md2man \
                           --disable-roll-simd \
                           --disable-xattr-support \
                           --disable-xxhash \
                           --disable-zstd \
                           --with-included-popt \
                           --without-included-zlib"

pre_make_host() {
  # do not detect LE git version
  echo "#define RSYNC_GITVER \"${PKG_VERSION}\"" >git-version.h
}

pre_make_target() {
  pre_make_host
}
