# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aic8800"
PKG_VERSION="4.0+git20250410.b99ca8b6-5"
PKG_SHA256="918cf935a24d211ef56084eb0a0027c0ae13480e88730c2170b67bebfd214966"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/radxa-pkg/${PKG_NAME}"
PKG_URL="${PKG_SITE}/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_LONGDESC="Aicsemi aic8800 Wi-Fi driver."
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.1-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.5-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.7-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.9-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.12-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.13-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.14-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.15-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.16-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.17-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-linux-6.19-build.patch"
  patch -p1 < "${PKG_BUILD}/debian/patches/fix-sdio-firmware-path.patch"
}

make_target() {
  kernel_make -C "${PKG_BUILD}/src/SDIO/driver_fw/driver/${PKG_NAME}" \
    M="${PKG_BUILD}/src/SDIO/driver_fw/driver/${PKG_NAME}" \
    PWD="${PKG_BUILD}/src/SDIO/driver_fw/driver/${PKG_NAME}" \
    KDIR=$(kernel_path) \
    CONFIG_PLATFORM_UBUNTU=n \
    CONFIG_AIC_FW_PATH=/lib/firmware/aic8800_fw/SDIO/aic8800D80 \
    modules
}

makeinstall_target() {
  mkdir -p "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}"
    cp -av "${PKG_BUILD}/src/SDIO/driver_fw/driver/aic8800/"*/*.ko "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/"

  mkdir -p "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/SDIO"
    cp -av "${PKG_BUILD}/src/SDIO/driver_fw/fw/"* "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/SDIO/"
}
