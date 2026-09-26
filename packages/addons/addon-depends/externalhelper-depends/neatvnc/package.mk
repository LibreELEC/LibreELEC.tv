# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="neatvnc"
PKG_VERSION="1.0.2"
PKG_SHA256="06bd3aefb58d66aef14e42143e8f75c84e3b54fc800acb2d2a2de0f507359d50"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/any1/neatvnc"
PKG_URL="https://github.com/any1/neatvnc/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain aml ffmpeg gnutls jansson libjpeg-turbo libxkbcommon mesa pixman"
PKG_SHORTDESC="VNC server library that is intended to be fast and neat"

PKG_DEPENDS_CONFIG="wayland wayland-protocols"

PKG_MESON_OPTS_TARGET="-Dexamples=false \
                       -Dgbm=enabled \
                       -Dh264=enabled \
                       -Djpeg=enabled \
                       -Dnettle=disabled \
                       -Dtests=false \
					   -Dtls=enabled"
