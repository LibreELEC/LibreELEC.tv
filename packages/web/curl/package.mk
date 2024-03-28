# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="curl"
PKG_VERSION="8.6.0"
PKG_SHA256="3ccd55d91af9516539df80625f818c734dc6f2ecf9bada33c76765e99121db15"
PKG_LICENSE="MIT"
PKG_SITE="https://curl.haxx.se"
PKG_URL="https://curl.haxx.se/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib openssl rtmpdump libidn2 nghttp2"
PKG_LONGDESC="Client and library for (HTTP, HTTPS, FTP, ...) transfers."

PKG_CMAKE_OPTS_TARGET="-DENABLE_DEBUG=OFF \
                       -DCURL_LTO=ON \
                       -DCURL_WERROR=ON \
                       -DENABLE_CURLDEBUG=OFF \
                       -DENABLE_ARES=OFF \
                       -DCURL_DISABLE_HTTP=OFF \
                       -DCURL_DISABLE_FTP=OFF \
                       -DCURL_DISABLE_FILE=OFF \
                       -DCURL_DISABLE_LDAP=ON \
                       -DCURL_DISABLE_LDAPS=ON \
                       -DCURL_DISABLE_RTSP=OFF \
                       -DCURL_DISABLE_PROXY=OFF \
                       -DCURL_DISABLE_DICT=ON \
                       -DCURL_DISABLE_TELNET=ON \
                       -DCURL_DISABLE_TFTP=ON \
                       -DCURL_DISABLE_POP3=ON \
                       -DCURL_DISABLE_IMAP=ON \
                       -DCURL_DISABLE_SMB=ON \
                       -DCURL_DISABLE_SMTP=ON \
                       -DCURL_DISABLE_GOPHER=ON \
                       -DCURL_DISABLE_MQTT=ON \
                       -DENABLE_CURL_MANUAL=OFF \
                       -DENABLE_IPV6=ON \
                       -DENABLE_THREADED_RESOLVER=ON \
                       -DCURL_DISABLE_VERBOSE_STRINGS=OFF \
                       -DCURL_WINDOWS_SSPI=OFF \
                       -DCURL_DISABLE_COOKIES=OFF \
                       -DCURL_HIDDEN_SYMBOLS=ON \
                       -DCURL_USE_GSSAPI=OFF \
                       -DUSE_ZLIB=ON \
                       -DCURL_BROTLI=OFF \
                       -DCURL_ZSTD=OFF \
                       -DRANDOM_FILE=/dev/urandom \
                       -DCURL_USE_GNUTLS=OFF \
                       -DCURL_ENABLE_SSL=ON \
                       -DCURL_USE_MBEDTLS=OFF \
                       -DCURL_CA_BUNDLE=/run/libreelec/cacert.pem \
                       -DCURL_CA_PATH=none \
                       -DCURL_USE_LIBPSL=OFF \
                       -DCURL_USE_LIBSSH2=OFF \
                       -DUSE_LIBRTMP=ON \
                       -DUSE_LIBIDN2=ON \
                       -DUSE_NGHTTP2=ON"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/zsh

  rm -rf ${INSTALL}/usr/bin/${PKG_NAME}-config
  cp ${PKG_NAME}-config ${TOOLCHAIN}/bin
  sed -e "s:\(['= ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/${PKG_NAME}-config
  chmod +x ${TOOLCHAIN}/bin/${PKG_NAME}-config
}
