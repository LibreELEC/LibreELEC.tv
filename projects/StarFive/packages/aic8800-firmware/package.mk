# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

# Firmware for the AIC8800D80 SDIO WiFi/Bluetooth chip of the VisionFive 2
# Lite, matching the aic8800D80 driver of the StarFive vendor kernel, which
# reads it from /lib/firmware/aic8800_sdio (CONFIG_AIC_FW_PATH).
# From the buildroot of VisionFive2 tag JH7110_VF2_6.12_v6.0.0.

PKG_NAME="aic8800-firmware"
PKG_VERSION="70e7c10de57195237ee4ae95f3c87637a39429b0"
PKG_SHA256="cbc0985ba0f97fd10256a12825acef7c90300a52925bbc696f1ec089b109021f"
PKG_ARCH="riscv64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://github.com/starfive-tech/buildroot/tree/JH7110_VisionFive2_devel/package/starfive/starfive-firmware/aic8800-sdio-wifi"
PKG_URL="https://github.com/starfive-tech/buildroot/archive/${PKG_VERSION}.tar.gz"
PKG_SOURCE_NAME="buildroot-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="AIC8800D80 SDIO WiFi and Bluetooth firmware for the VisionFive 2 Lite"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}
    tar --strip-components=6 -xf ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} -C ${PKG_BUILD} \
      buildroot-${PKG_VERSION}/package/starfive/starfive-firmware/aic8800-sdio-wifi/aic8800D80
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/aic8800_sdio
    cp -a ${PKG_BUILD}/* ${INSTALL}/$(get_full_firmware_dir)/aic8800_sdio
}
