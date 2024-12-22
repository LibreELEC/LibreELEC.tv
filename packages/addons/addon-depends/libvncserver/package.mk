# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libvncserver"
PKG_VERSION="0.9.15"
PKG_SHA256="62352c7795e231dfce044beb96156065a05a05c974e5de9e023d688d8ff675d7"
PKG_LICENSE="GPL"
PKG_SITE="https://libvnc.github.io/"
PKG_URL="https://github.com/LibVNC/libvncserver/archive/LibVNCServer-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo libpng openssl systemd"
PKG_LONGDESC="A C library that allow you to easily implement VNC server or client functionality."

PKG_CMAKE_OPTS_TARGET="-DWITH_GCRYPT=0 \
                       -DWITH_GNUTLS=0 \
                       -DWITH_GTK=0 \
                       -DWITH_SDL=0 \
                       -DWITH_TIGHTVNC_FILETRANSFER=0 \
                       -DWITH_EXAMPLES=OFF \
                       -DWITH_TESTS=OFF \
                       -DWITH_QT=OFF"
