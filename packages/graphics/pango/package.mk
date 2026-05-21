# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pango"
PKG_VERSION="1.58.2"
PKG_SHA256="342385b6ca3b7c73455d7c80a13b7dbe4489e00bc3bd4c5bd6ed4dce421e374a"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="http://www.pango.org/"
PKG_URL="https://download.gnome.org/sources/pango/${PKG_VERSION:0:4}/pango-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo freetype fontconfig fribidi glib json-glib harfbuzz"
PKG_DEPENDS_CONFIG="cairo"
PKG_LONGDESC="The Pango library for layout and rendering of internationalized text."

configure_package() {
  # Build with X11 support
  if [ ${DISPLAYSERVER} = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libX11 libXft"
    PKG_DEPENDS_CONFIG+=" libXft"
    PKG_BUILD_FLAGS="-sysroot"
  elif [ ${DISPLAYSERVER} != "wl" ]; then
    PKG_BUILD_FLAGS="-sysroot"
  fi
}

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="-Ddocumentation=false \
                         -Dintrospection=disabled"
}
