# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Overlay of LibreELEC components: keep the Variscite flash.bin already on the SD card.
# Mainline u-boot 2026.07 has no imx8mp_var_dart_defconfig.

PKG_NAME="u-boot"
PKG_VERSION="variscite-2024.04"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/varigit/uboot-imx"
PKG_LONGDESC="Stub U-Boot package. The running board already has Variscite lf-2024.04 flash.bin."
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="toolchain"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  # Placeholder only — update.sh on this device does not write flash.bin.
  : >${INSTALL}/usr/share/bootloader/flash.bin

  find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

  if find_file_path bootloader/canupdate.sh; then
    cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
        -i ${INSTALL}/usr/share/bootloader/canupdate.sh
  fi
}
