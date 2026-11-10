# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="assimp"
PKG_VERSION="6.0.6"
PKG_SHA256="5f7ed412b76575621df0525a762b31da5874afff352b3a890c6308db4ac7204c"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/assimp/assimp"
PKG_URL="https://github.com/assimp/assimp/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="A library to import and export various 3d-model-formats including scene-post-processing to generate missing render data."

PKG_CMAKE_OPTS_TARGET="-DASSIMP_BUILD_ASSIMP_TOOLS=OFF \
                       -DASSIMP_BUILD_TESTS=OFF \
                       -DASSIMP_WARNINGS_AS_ERRORS=OFF"
