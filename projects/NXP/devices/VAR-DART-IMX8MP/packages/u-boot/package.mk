# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Do not build U-Boot. Mainline has no matching imx8mp_var_dart_defconfig.
# SD overlay keeps the flash.bin already on the card. eMMC UUU uses a
# vendor imx-boot dropped in devices/$DEVICE/vendor/imx-boot/.

PKG_NAME="u-boot"
PKG_VERSION="variscite-2024.04"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/varigit/uboot-imx"
PKG_LONGDESC="Stub U-Boot package. Use Variscite lf-2024.04 imx-boot from vendor/imx-boot."
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="toolchain"

vendor_imx_boot() {
  local d="${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/vendor/imx-boot"
  if [ -s "${d}/imx-boot" ]; then
    echo "${d}/imx-boot"
  elif [ -s "${d}/flash.bin" ]; then
    echo "${d}/flash.bin"
  fi
}

make_target() {
  local src
  src="$(vendor_imx_boot)"
  mkdir -p ${PKG_BUILD}
  if [ -n "${src}" ]; then
    cp -a "${src}" ${PKG_BUILD}/flash.bin
  else
    : >${PKG_BUILD}/flash.bin
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  # Empty stub must never be flashed. update.sh will not dd a 0-byte file.
  if [ -s ${PKG_BUILD}/flash.bin ]; then
    cp -a ${PKG_BUILD}/flash.bin ${INSTALL}/usr/share/bootloader/flash.bin
  else
    : >${INSTALL}/usr/share/bootloader/flash.bin
  fi

  find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

  if find_file_path bootloader/canupdate.sh; then
    cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
        -i ${INSTALL}/usr/share/bootloader/canupdate.sh
  fi
}
