# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fluidsynth"
PKG_VERSION="2.6.3"
PKG_SHA256="c51ebe04c8a445f4a7dd5a86e09a27b5c5af547756574edc52fc61c88ebe8427"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="http://fluidsynth.org/"
PKG_URL="https://github.com/FluidSynth/fluidsynth/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libsndfile gcem"
PKG_LONGDESC="FluidSynth renders midi music files as raw audio data, for playing or conversion."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0 \
                       -Denable-dbus=0 \
                       -Denable-libsndfile=1 \
                       -Denable-pulseaudio=0 \
                       -Denable-readline=0 \
                       -Denable-systemd=0"
