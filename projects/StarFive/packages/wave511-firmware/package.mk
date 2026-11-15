# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

# Chips&Media Wave511 decoder firmware for the wave5 V4L2 driver in the
# StarFive vendor kernel ("starfive,vdec", loads wave511_dec_fw.bin).
# From StarFive buildroot, commit "Wave511: add firmware wave511_dec_fw.bin
# for wave5 v4l2 driver" (not the chagall.bin of the old OMX stack).

PKG_NAME="wave511-firmware"
PKG_VERSION="8c06ed2f3e5811f27537b9613891f0111364d2d1"
PKG_SHA256="398eb201cf4d6c5050856de5660764a743b8879a69b8684d12aadb556409b79c"
PKG_ARCH="riscv64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://github.com/starfive-tech/buildroot/tree/JH7110_VisionFive2_devel/package/starfive/wave511"
PKG_URL="https://github.com/starfive-tech/buildroot/raw/${PKG_VERSION}/package/starfive/wave511/wave511_dec_fw.bin"
PKG_SOURCE_NAME="wave511_dec_fw-${PKG_VERSION}.bin"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Chips&Media Wave511 video decoder firmware for the StarFive JH7110"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}
    cp ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} ${PKG_BUILD}/wave511_dec_fw.bin
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)
    cp -a ${PKG_BUILD}/wave511_dec_fw.bin ${INSTALL}/$(get_full_firmware_dir)
    cp -a ${PKG_DIR}/license/LICENSE.wave511 ${INSTALL}/$(get_full_firmware_dir)
}
