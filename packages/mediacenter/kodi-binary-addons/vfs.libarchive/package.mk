# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vfs.libarchive"
PKG_VERSION="22.0.1-Piers"
PKG_SHA256="f9fbb7cd6c756d28168297b4a8924949228e0bd927d191a0c548873e62cd5d3c"
PKG_REV="8"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/vfs.libarchive"
PKG_URL="https://github.com/xbmc/vfs.libarchive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform bzip2 libarchive lz4 lzo xz zlib"
PKG_SECTION=""
PKG_SHORTDESC="vfs.libarchive"
PKG_LONGDESC="vfs.libarchive"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.vfs"

pre_configure_target() {
  export LibLZMA_ROOT="$(get_install_dir xz)/usr"
  sed -i -e 's/^cmake_minimum_required(VERSION 3.5)/cmake_minimum_required(VERSION 3.12)/' \
         -e 's/^find_package(LibLZMA REQUIRED)/set(CMAKE_FIND_OLD_ROOT_PATH ${CMAKE_FIND_ROOT_PATH})\nset(CMAKE_FIND_ROOT_PATH "")\nfind_package(LibLZMA REQUIRED)\nset(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_OLD_ROOT_PATH})/' ../CMakeLists.txt
}
