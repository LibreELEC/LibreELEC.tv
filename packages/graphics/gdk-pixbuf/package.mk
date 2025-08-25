# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gdk-pixbuf"
PKG_VERSION="2.43.3"
PKG_SHA256="ed4c5d16346a5b4e95326731de9700fad70d03bbd2f9324732e6c94f42d869d7"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${PKG_VERSION:0:4}/gdk-pixbuf-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib glycin libjpeg-turbo libpng jasper shared-mime-info tiff"
PKG_DEPENDS_CONFIG="shared-mime-info"
PKG_LONGDESC="GdkPixbuf is a a GNOME library for image loading and manipulation."

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libX11"
  fi
}

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="--wrap-mode=nodownload \
                         -Ddocumentation=false \
                         -Dintrospection=disabled \
                         -Dman=false \
                         -Drelocatable=false \
                         -Dinstalled_tests=false \
                         -Dtests=false"

  if [ "${DISPLAYSERVER}" != "x11" ]; then
    PKG_MESON_OPTS_TARGET+=" -Dbuiltin_loaders=all"
  fi

  export PKG_CONFIG_PATH="$(get_install_dir glycin)/usr/lib/pkgconfig:$(get_install_dir libseccomp)/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
}
