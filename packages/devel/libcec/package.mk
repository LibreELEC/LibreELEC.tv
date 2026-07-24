# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libcec"
PKG_VERSION="8.1.0"
PKG_SHA256="11fef68e5a77adf30519096c333d4cdb3f4cfd1d9e0a6d679636899c5807f585"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://libcec.pulse-eight.com/"
PKG_URL="https://github.com/Pulse-Eight/libcec/archive/libcec-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd swig:host"
PKG_LONGDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=1 \
                       -DCMAKE_INSTALL_LIBDIR:STRING=lib \
                       -DSKIP_PYTHON_WRAPPER=1 \
                       -DHAVE_IMX_API=0 \
                       -DHAVE_AOCEC_API=0 \
                       -DGIT_BIN=0 \
                       -DHAVE_RPI_LIB=0"

# libX11 and xrandr to read the sink's EDID, used to determine the PC's HDMI physical address
if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libX11 libXrandr"
fi

if [ "${CEC_FRAMEWORK_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DHAVE_LINUX_API=1"
else
  PKG_CMAKE_OPTS_TARGET+=" -DHAVE_LINUX_API=0"
fi

post_makeinstall_target() {
  # Remove the Python3 demo - useless for us
  rm -f ${INSTALL}/usr/bin/pyCecClient

  PYTHON_DIR=${INSTALL}/usr/lib/${PKG_PYTHON_VERSION}
  if [ -d ${PYTHON_DIR}/dist-packages ]; then
    mv ${PYTHON_DIR}/dist-packages ${PYTHON_DIR}/site-packages
  fi
}
