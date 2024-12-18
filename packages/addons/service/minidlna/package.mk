# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minidlna"
PKG_VERSION="1.3.3"
PKG_SHA256="39026c6d4a139b9180192d1c37225aa3376fdf4f1a74d7debbdbb693d996afa4"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="BSD-3c/GPLv2"
PKG_SITE="https://sourceforge.net/projects/minidlna/"
PKG_URL="https://downloads.sourceforge.net/project/minidlna/minidlna/${PKG_VERSION}/minidlna-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ffmpeg flac libexif libiconv libid3tag libjpeg-turbo libogg libvorbis sqlite"
PKG_SECTION="service"
PKG_SHORTDESC="MiniDLNA (ReadyMedia): a fully compliant DLNA/UPnP-AV server"
PKG_LONGDESC="MiniDLNA (${PKG_VERSION_DATE}) (ReadyMedia) is a media server, with the aim of being fully compliant with DLNA/UPnP-AV clients."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="MiniDLNA (ReadyMedia)"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --disable-nls \
                           --without-libiconv-prefix \
                           --without-libintl-prefix \
                           --with-os-name="${DISTRONAME}" \
                           --with-db-path="/storage/.kodi/userdata/addon_data/service.minidlna/db" \
                           --with-os-url="https://libreelec.tv""

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -L$(get_install_dir ffmpeg)/usr/lib"
  export LIBS="${LIBS} -lid3tag -lFLAC -logg -lz -lpthread -ldl -lm"
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_INSTALL}/usr/sbin/minidlnad ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    patchelf --add-rpath '${ORIGIN}/../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/minidlnad

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -p $(get_install_dir libexif)/usr/lib/libexif.so.12 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
}
