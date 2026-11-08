# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="espeak-ng"
PKG_VERSION="03dd840a25d89539b1145fd55e15a635a8c77bdb"
PKG_SHA256="7272e190f37ccb147fed9dec2eba7a822d0d09dbfb52f881d3993aa816dbb226"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/espeak-ng/espeak-ng"
PKG_URL="https://github.com/espeak-ng/espeak-ng/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cmake:host ninja:host sonic:host"
PKG_DEPENDS_TARGET="toolchain espeak-ng:host sonic"
PKG_LONGDESC="eSpeak NG is an open source speech synthesizer that supports more than a hundred languages and accents"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_HOST="-DBUILD_SHARED_LIBS=OFF \
                     -DCOMPILE_INTONATIONS=OFF \
                     -DENABLE_TESTS=OFF \
                     -DESPEAK_COMPAT=OFF \
                     -DUSE_LIBSONIC=ON"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DCOMPILE_INTONATIONS=ON \
                       -DENABLE_TESTS=OFF \
                       -DESPEAK_COMPAT=OFF \
                       -DUSE_LIBSONIC=ON \
                       -DNativeBuild_DIR=${TOOLCHAIN}/bin"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/share/vim

  # add symlink for backwards compatibility with old programs
  ln -sf espeak-ng ${INSTALL}/usr/bin/espeak
}
