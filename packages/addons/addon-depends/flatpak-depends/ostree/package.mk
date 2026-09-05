# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ostree"
PKG_VERSION="2026.4"
PKG_SHA256="b26c9016eb03bb4ee52cc00c642d56e00fc79ae7faac6bf4aa317d7451339ef7"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="https://github.com/ostreedev/ostree"
PKG_URL="https://github.com/ostreedev/ostree/releases/download/v${PKG_VERSION}/libostree-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain curl e2fsprogs fuse3 glib gpgme libassuan libgpg-error libarchive xz zlib"
PKG_DEPENDS_CONFIG="gpgme libassuan"
PKG_LONGDESC="Operating system and container binary deployment and upgrades"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-man \
                           --without-avahi \
                           --without-composefs \
                           --with-curl \
                           --without-dracut \
                           --with-gpgme \
                           --with-gpg-error-prefix=${SYSROOT_PREFIX}/usr \
                           --without-grub2 \
                           --with-libarchive \
                           --without-libsystemd \
                           --without-modern-grub \
                           --without-soup3 \
                           --without-soup \
                           --without-smack"

pre_configure_target() {
  export OT_DEP_LIBARCHIVE_CFLAGS="$(${PKG_CONFIG} --cflags --static libarchive)"
  export OT_DEP_LIBARCHIVE_LIBS="$(${PKG_CONFIG} --libs --static libarchive)"

  export CFLAGS+=" -I$(get_install_dir gpgme)/usr/include"
  export LDFLAGS+=" -L$(get_install_dir gpgme)/usr/lib"
}
