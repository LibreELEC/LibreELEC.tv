# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="7-zip"
PKG_VERSION="24.07"
PKG_SHA256="d1b0874a3f1c26df21c761a4a30691dc1213e8577f18ee78326c14ca4d683e2b"
PKG_LICENSE="7-Zip"
PKG_SITE="https://www.7-zip.org"
PKG_URL="https://www.7-zip.org/a/7z${PKG_VERSION/./}-src.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="make:host gcc:host"
PKG_LONGDESC="7-Zip is a file archiver with a high compression ratio"
PKG_TAR_STRIP_COMPONENTS="--strip-components=0"
PKG_TOOLCHAIN="manual"

pre_build_host() {
  rm -fr ${PKG_BUILD}/.${HOST_NAME}
  mkdir -p ${PKG_BUILD}/.${HOST_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${HOST_NAME}
}

make_host() {
  # compile without 7-Zip's assembler code (not required in toolchain)
  make CXX=${CXX} CC=${CC} -f makefile.gcc -C ${PKG_BUILD}/.${HOST_NAME}/CPP/7zip/Bundles/Alone
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
  cp ${PKG_BUILD}/.${HOST_NAME}/CPP/7zip/Bundles/Alone/_o/7za ${TOOLCHAIN}/bin
}

pre_build_target() {
  rm -fr ${PKG_BUILD}/.${TARGET_NAME}
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}

make_target() {
  # arm (arm32) does not have an assembler code option for 7-Zip
  # dont use x86_64 ../../cmpl_gcc_x64.mak file to build 7-Zip's assembler code (as asmc is not available)
  if [ "${TARGET_ARCH}" = "aarch64" ]; then
    make CXX=${CXX} CC=${CC} -f ../../cmpl_gcc_arm64.mak -C ${PKG_BUILD}/.${TARGET_NAME}/CPP/7zip/Bundles/Alone2
  else
    make CXX=${CXX} CC=${CC} -f makefile.gcc -C ${PKG_BUILD}/.${TARGET_NAME}/CPP/7zip/Bundles/Alone2
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  if [ "${TARGET_ARCH}" = "aarch64" ]; then
    cp -p ${PKG_BUILD}/.${TARGET_NAME}/CPP/7zip/Bundles/Alone2/b/g_arm64/7zz ${INSTALL}/usr/bin
  else
    cp -p ${PKG_BUILD}/.${TARGET_NAME}/CPP/7zip/Bundles/Alone2/_o/7zz ${INSTALL}/usr/bin
  fi
}
