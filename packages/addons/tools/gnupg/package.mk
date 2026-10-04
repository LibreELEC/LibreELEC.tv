# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gnupg"
PKG_REV="0"
PKG_VERSION="2.5.24"
PKG_SHA256="bf149d01a2b9fcc0e4589b8ae8697d3d5c557ea48ed95a3fa55dd3b1187e6039"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://www.gnupg.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libassuan libgcrypt libgpg-error libksba libnpth zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="GnuPG - The Universal Crypto Engine"
PKG_LONGDESC="GnuPG - The Universal Crypto Engine"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="GnuPG"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --disable-rpath \
                           --disable-tests \
                           --disable-gpgsm \
                           --disable-scdaemon \
                           --disable-dirmngr \
                           --disable-keyboxd \
                           --disable-tpm2d \
                           --disable-gpgtar \
                           --disable-wks-tools \
                           --disable-libdns \
                           --disable-exec \
                           --disable-sqlite \
                           --disable-photo-viewers \
                           --disable-card-support \
                           --disable-ccid-driver \
                           --disable-ntbtls \
                           --disable-gnutls \
                           --disable-ldap \
                           --disable-nls \
                           --without-bzip2 \
                           --without-readline \
                           --with-agent-pgm=/storage/.kodi/addons/tools.gnupg/bin/gpg-agent \
                           --with-libassuan-prefix=$(get_install_dir libassuan)/usr \
                           --with-ksba-prefix=$(get_install_dir libksba)/usr \
                           --with-npth-prefix=$(get_install_dir libnpth)/usr \
                           --with-libgpg-error-prefix=${SYSROOT_PREFIX}/usr"

pre_configure_target() {
   export LIBGCRYPT_CONFIG="${SYSROOT_PREFIX}/usr/bin/libgcrypt-config"

   CFLAGS+=" -I$(get_install_dir libassuan)/usr/include \
             -I$(get_install_dir libksba)/usr/include \
             -I$(get_install_dir libnpth)/usr/include "
   LDFLAGS+=" -L$(get_install_dir libassuan)/usr/lib \
              -L$(get_install_dir libksba)/usr/lib \
              -L$(get_install_dir libnpth)/usr/lib "
}

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp "${PKG_INSTALL}/usr/bin/"{gpg,gpg-agent} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
}
