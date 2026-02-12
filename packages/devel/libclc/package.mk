# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libclc"
PKG_VERSION="$(get_pkg_version llvm)"
PKG_LICENSE="Apache-2.0"
PKG_URL=""
PKG_DEPENDS_HOST="toolchain:host llvm:host"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure."
PKG_DEPENDS_UNPACK+=" llvm"
PKG_PATCH_DIRS+=" $(get_pkg_directory llvm)/patches"
PKG_TOOLCHAIN="cmake"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/llvm/llvm-${PKG_VERSION}.tar.xz -C ${PKG_BUILD}
}

pre_configure() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/libclc/CMakeLists.txt"
}

pre_configure_host() {
  LIBCLC_TARGETS_TO_BUILD="spirv64-mesa3d-"

  mkdir -p "${PKG_BUILD}/.${HOST_NAME}"
  cd ${PKG_BUILD}/.${HOST_NAME}
  PKG_CMAKE_OPTS_HOST="-DLIBCLC_TARGETS_TO_BUILD=${LIBCLC_TARGETS_TO_BUILD}"
}

pre_configure_target() {
  LIBCLC_TARGETS_TO_BUILD="spirv64-mesa3d-"

  mkdir -p "${PKG_BUILD}/.${TARGET_NAME}"
  cd ${PKG_BUILD}/.${TARGET_NAME}
  PKG_CMAKE_OPTS_TARGET="-DLIBCLC_TARGETS_TO_BUILD=${LIBCLC_TARGETS_TO_BUILD}"
}
