# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="imagedecoder.heif"
PKG_VERSION="22.1.3-Piers"
PKG_SHA256="186539681e6067fa24ed3c0f526301224de30edbbda24e347af3d79569603cdd"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/xbmc/imagedecoder.heif"
PKG_URL="https://github.com/xbmc/imagedecoder.heif/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libheif tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="imagedecoder.heif"
PKG_LONGDESC="imagedecoder.heif"
# libde265 needs __cpu_model, which is only in libgcc.a
PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_STANDARD_LIBRARIES=-lgcc"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.imagedecoder"
