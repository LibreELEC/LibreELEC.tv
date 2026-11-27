# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mimalloc"
PKG_VERSION="3.7.1"
PKG_SHA256="8bc9f820eaf3dad3509d7930d80c40512bc51e04989641f892ee64c46b7ab0d8"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/microsoft/mimalloc"
PKG_URL="https://github.com/microsoft/mimalloc/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cmake:host ninja:host"
PKG_LONGDESC="mimalloc (pronounced "me-malloc") is a general purpose allocator with excellent performance characteristics"

PKG_CMAKE_OPTS_HOST="-DMI_SECURE=OFF \
                     -DMI_DEBUG_FULL=OFF \
                     -DMI_OVERRIDE=ON \
                     -DMI_XMALLOC=OFF \
                     -DMI_SHOW_ERRORS=OFF \
                     -DMI_USE_CXX=OFF \
                     -DMI_SEE_ASM=OFF \
                     -DMI_LOCAL_DYNAMIC_TLS=OFF \
                     -DMI_BUILD_SHARED=ON \
                     -DMI_BUILD_STATIC=OFF \
                     -DMI_BUILD_OBJECT=OFF \
                     -DMI_BUILD_TESTS=OFF \
                     -DMI_DEBUG_TSAN=OFF \
                     -DMI_DEBUG_UBSAN=OFF \
                     -DMI_SKIP_COLLECT_ON_EXIT=OFF \
                     -DMI_BIG_ENDIAN=OFF"
