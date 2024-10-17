# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nano"
PKG_VERSION="8.2"
PKG_SHA256="d5ad07dd862facae03051c54c6535e54c7ed7407318783fcad1ad2d7076fffeb"
PKG_LICENSE="GPL"
PKG_SITE="https://www.nano-editor.org/"
PKG_URL="https://www.nano-editor.org/dist/v${PKG_VERSION%%.*}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Nano is an enhanced clone of the Pico text editor."
PKG_BUILD_FLAGS="-cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--disable-utf8 \
                           --disable-nls \
                           --disable-libmagic \
                           --disable-wrapping"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/nano

  mkdir -p ${INSTALL}/etc
  cp -a ${PKG_DIR}/config/* ${INSTALL}/etc/

  mkdir -p ${INSTALL}/usr/share/nano

  PKG_FILE_LIST="css html java javascript json php python sh xml"
  for PKG_FILE_TYPES in ${PKG_FILE_LIST}; do
    cp -a ${PKG_BUILD}/syntax/${PKG_FILE_TYPES}.nanorc ${INSTALL}/usr/share/nano/
  done
}
