# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tvheadend43"
PKG_VERSION="7cbe50c6e646e0d2443ef5bd73ba3c49c3c632c3"
PKG_SHA256="803276477ec580250c2203c1bcf2b75de1ae8758693b279aa21b0aea3c094384"
PKG_VERSION_NUMBER="4.3-2466"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvheadend.org"
PKG_URL="https://github.com/tvheadend/tvheadend/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain argtable2 avahi comskip curl dvb-apps ffmpegx libdvbcsa libhdhomerun \
                    libiconv openssl pcre2 pngquant:host Python3:host dtv-scan-tables"
PKG_DEPENDS_CONFIG="ffmpegx"
PKG_SECTION="service"
PKG_SHORTDESC="Tvheadend: a TV streaming server for Linux"
PKG_LONGDESC="Tvheadend (${PKG_VERSION_NUMBER}): is a TV streaming server for Linux supporting DVB-S/S2, DVB-C, DVB-T/T2, IPTV, SAT>IP, ATSC and ISDB-T"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tvheadend Server 4.3"
PKG_ADDON_TYPE="xbmc.service"

# basic transcoding options
PKG_TVH_TRANSCODING="\
  --disable-ffmpeg_static \
  --disable-libfdkaac_static \
  --disable-libopus_static \
  --disable-libtheora \
  --disable-libtheora_static \
  --disable-libvorbis_static \
  --disable-libvpx_static \
  --disable-libx264_static \
  --disable-libx265_static \
  --enable-libav \
  --enable-libfdkaac \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libx264"

# hw specific transcoding options
if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" libva"
  # specific transcoding options
  PKG_TVH_TRANSCODING="${PKG_TVH_TRANSCODING} \
    --enable-vaapi \
    --enable-libvpx \
    --enable-libx265"
else
  # for != "x86_64" targets
  # specific transcoding options
  PKG_TVH_TRANSCODING="${PKG_TVH_TRANSCODING} \
    --disable-libvpx \
    --disable-libx265"
fi

post_unpack() {
  sed -e 's/VER="0.0.0~unknown"/VER="'${PKG_VERSION_NUMBER}' ~ LibreELEC Tvh-addon v'${ADDON_VERSION}'.'${PKG_REV}'"/g' -i ${PKG_BUILD}/support/version
  sed -e 's|'/usr/bin/pngquant'|'${TOOLCHAIN}/bin/pngquant'|g' -i ${PKG_BUILD}/support/mkbundle
}

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                             --arch=${TARGET_ARCH} \
                             --cpu=${TARGET_CPU} \
                             --cc=${CC} \
                             ${PKG_TVH_TRANSCODING} \
                             --enable-avahi \
                             --enable-bundle \
                             --disable-dbus_1 \
                             --enable-dvbcsa \
                             --disable-dvben50221 \
                             --disable-dvbscan \
                             --enable-hdhomerun_client \
                             --disable-hdhomerun_static \
                             --enable-epoll \
                             --enable-inotify \
                             --enable-pngquant \
                             --disable-libmfx_static \
                             --disable-nvenc \
                             --disable-uriparser \
                             --enable-tvhcsa \
                             --enable-trace \
                             --nowerror \
                             --disable-bintray_cache \
                             --python=${TOOLCHAIN}/bin/python"

  # fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}

  # pass ffmpegx to build
  CFLAGS+=" -I$(get_install_dir ffmpegx)/usr/local/include"
  LDFLAGS+=" -L$(get_install_dir ffmpegx)/usr/local/lib"

  # pass libhdhomerun to build
  CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/hdhomerun"

  export CROSS_COMPILE="${TARGET_PREFIX}"
  export CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/iconv -L${SYSROOT_PREFIX}/usr/lib/iconv"
}

post_make_target() {
  ${CC} -O -fbuiltin -fomit-frame-pointer -fPIC -shared -o capmt_ca.so src/extra/capmt_ca.c -ldl
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  cp -p capmt_ca.so ${INSTALL}/usr/lib
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  cp ${PKG_DIR}/addon.xml ${ADDON_BUILD}/${PKG_ADDON_ID}

  # set only version (revision will be added by buildsystem)
  sed -e "s|@ADDON_VERSION@|${ADDON_VERSION}|g" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/addon.xml

  cp -P ${PKG_INSTALL}/usr/bin/tvheadend ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp -P ${PKG_INSTALL}/usr/lib/capmt_ca.so ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp -P $(get_install_dir comskip)/usr/bin/comskip ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  if [ "${TARGET_ARCH}" = "aarch64" ] || [ "${TARGET_ARCH}" = "x86_64" ]; then
    mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    cp -P $(get_install_dir x265)/usr/lib/libx265.so.215 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
    patchelf --add-rpath '${ORIGIN}/../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/{comskip,tvheadend}
  fi

  # dvb-scan files
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/dvb-scan
  cp -r $(get_install_dir dtv-scan-tables)/usr/share/dvbv5/* \
        ${ADDON_BUILD}/${PKG_ADDON_ID}/dvb-scan
}
