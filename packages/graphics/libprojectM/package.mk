# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libprojectM"
PKG_VERSION="9e26f5b5bf89b015f197a16a61bcb21f4946d985"
PKG_SHA256="3644691345e0d97e9fe51be76f8a08cd84050d096dc127cf083333535b36d0cc"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/projectM-visualizer/projectm"
PKG_URL="https://github.com/projectM-visualizer/projectm/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain freetype glm libprojectM-eval"
PKG_LONGDESC="A MilkDrop compatible opensource music visualizer."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DENABLE_SYSTEM_GLM=ON \
                       -DENABLE_SYSTEM_PROJECTM_EVAL=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_GLES=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_GLES=ON"
fi

pre_configure_target() {
  cp -a $(get_build_dir libprojectM-eval)/* ${PKG_BUILD}/vendor/projectm-eval
}
