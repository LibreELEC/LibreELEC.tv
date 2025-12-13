# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cryptsetup"
PKG_VERSION="2.8.1"
PKG_SHA256="2c3379eb76597dcab50911449b013e2697c4bffcc716dbbf0d9b0e8fbbb46fb4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.com/cryptsetup/cryptsetup"
PKG_URL="https://www.kernel.org/pub/linux/utils/cryptsetup/v2.8/cryptsetup-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libgcrypt popt json-c util-linux openssl lvm2-lib"
PKG_SECTION="sysutils"
PKG_SHORTDESC="Userspace setup tool for transparent encryption of block devices using dm-crypt"

PKG_MESON_OPTS_TARGET="-Dfips=true \
                       -Dveritysetup=false \
                       -Dluks2-reencryption=false \
                       -Dintegritysetup=false \
                       -Dasciidoc=disabled \
                       -Dssh-token=false \
                       -Dgcrypt-pbkdf2=enabled"
