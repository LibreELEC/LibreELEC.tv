# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cryptsetup"
PKG_VERSION="2.6.1"
PKG_SHA256="410ded65a1072ab9c8e41added37b9729c087fef4d2db02bb4ef529ad6da4693"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.com/cryptsetup/cryptsetup"
PKG_URL="https://www.kernel.org/pub/linux/utils/cryptsetup/v2.6/cryptsetup-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libgcrypt popt json-c util-linux openssl lvm2-lib"
PKG_SECTION="sysutils"
PKG_SHORTDESC="Userspace setup tool for transparent encryption of block devices using dm-crypt"

PKG_CONFIGURE_OPTS_TARGET="--enable-fips \
                           --disable-veritysetup \
                           --disable-cryptsetup-reencrypt \
                           --disable-integritysetup \
                           --disable-asciidoc \
                           --disable-ssh-token \
                           --enable-gcrypt-pbkdf2 \
                           --with-sysroot=$SYSROOT_PREFIX \
                           --with-libgcrypt-prefix=$SYSROOT_PREFIX/usr"
