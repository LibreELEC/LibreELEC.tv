# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qtbase"
PKG_VERSION="5.15.2"
PKG_SHA256="909fad2591ee367993a75d7e2ea50ad4db332f05e1c38dd7a5a274e156a4e0f8"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/archive/qt/${PKG_VERSION%.*}/$PKG_VERSION/submodules/$PKG_NAME-everywhere-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="freetype libjpeg-turbo libpng openssl sqlite zlib"
PKG_LONGDESC="A cross-platform application and UI framework."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr
                           -sysroot "${SYSROOT_PREFIX}"
                           -hostprefix "${TOOLCHAIN}"
                           -device linux-libreelec-g++
                           -opensource -confirm-license
                           -release
                           -optimize-size
                           -strip
                           -static
                           -silent
                           -force-pkg-config
                           -make libs
                           -no-dbus
                           -no-accessibility
                           -no-glib
                           -no-iconv
                           -no-icu
                           -qt-pcre
                           -system-zlib
                           -openssl-linked
                           -no-libproxy
                           -no-cups
                           -no-fontconfig
                           -system-freetype
                           -no-harfbuzz
                           -no-opengl
                           -no-egl
                           -no-eglfs
                           -no-gbm
                           -no-kms
                           -no-linuxfb
                           -no-xcb
                           -no-feature-vnc
                           -no-feature-sessionmanager
                           -no-feature-easingcurve
                           -no-feature-effects
                           -no-feature-gestures
                           -no-feature-itemmodel
                           -no-libudev
                           -no-evdev
                           -no-libinput
                           -no-mtdev
                           -no-tslib
                           -no-xkbcommon
                           -no-gif
                           -no-ico
                           -system-libpng
                           -system-libjpeg
                           -no-sql-mysql
                           -system-sqlite"

configure_target() {
  QMAKE_CONF_DIR="mkspecs/devices/linux-libreelec-g++"

  cd ..
  mkdir -p ${QMAKE_CONF_DIR}

  cat >"${QMAKE_CONF_DIR}/qmake.conf" <<EOF
MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
load(device_config)
QMAKE_CC         = ${CC}
QMAKE_CXX        = ${CXX}
QMAKE_LINK       = ${CXX}
QMAKE_LINK_SHLIB = ${CXX}
QMAKE_AR         = ${AR} cqs
QMAKE_OBJCOPY    = ${OBJCOPY}
QMAKE_NM         = ${NM} -P
QMAKE_STRIP      = ${STRIP}
QMAKE_CFLAGS     = ${CFLAGS}
QMAKE_CXXFLAGS   = ${CXXFLAGS}
QMAKE_LFLAGS     = ${LDFLAGS}
load(qt_config)
EOF

  cat >"${QMAKE_CONF_DIR}/qplatformdefs.h" <<EOF
#include "../../linux-g++/qplatformdefs.h"
EOF

  unset CC CXX LD RANLIB AR AS CPPFLAGS CFLAGS LDFLAGS CXXFLAGS
  ./configure ${PKG_CONFIGURE_OPTS_TARGET}
}
