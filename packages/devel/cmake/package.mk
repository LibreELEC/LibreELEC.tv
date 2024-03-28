# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cmake"
PKG_VERSION="3.29.0"
PKG_SHA256="a0669630aae7baa4a8228048bf30b622f9e9fd8ee8cedb941754e9e38686c778"
PKG_LICENSE="BSD"
PKG_SITE="https://cmake.org/"
PKG_URL="https://cmake.org/files/v$(get_pkg_version_maj_min)/cmake-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="pkg-config:host"
PKG_LONGDESC="A cross-platform, open-source make system."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+local-cc"

configure_host() {
  ../configure --prefix=${TOOLCHAIN} \
               --no-qt-gui --no-system-libs \
               -- \
               -DCMAKE_C_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_CXX_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_EXE_LINKER_FLAGS="${HOST_LDFLAGS}" \
               -DCMAKE_USE_OPENSSL=OFF \
               -DBUILD_CursesDialog=0
}
