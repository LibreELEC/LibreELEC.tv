# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snapcast"
PKG_VERSION="8b7ac6986f2b37efba8087c05e35248649489d9e"
PKG_SHA256="e09760bcfd09ca25041dd1f259862493d7c97426183b9f42d72d0fa2835b8be3"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/badaix/snapcast"
PKG_URL="https://github.com/badaix/snapcast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain aixlog alsa-lib asio avahi flac libvorbis popl pulseaudio boost opus"
PKG_LONGDESC="Synchronous multi-room audio player."
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  CXXFLAGS="${CXXFLAGS} -pthread \
                      -I$(get_install_dir aixlog)/usr/include \
                      -I$(get_install_dir asio)/usr/include \
                      -I$(get_install_dir popl)/usr/include"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p ../bin/{snapclient,snapserver} ${INSTALL}/usr/bin
}
