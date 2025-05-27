# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"
PKG_VERSION="7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
PKG_SHA256="18bde6ce71df308197db0e1d95fd73a19b6a32f4f0b6f5567333ef3c5b617452"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/rkbin"
PKG_URL="https://github.com/rockchip-linux/rkbin/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_STAMP="$UBOOT_SYSTEM"

make_target() {
  if [ -n "${UBOOT_SYSTEM}" ]; then
    PKG_SOC=$("${ROOT}/${SCRIPTS}/uboot_helper" "${PROJECT}" "${DEVICE}" "${UBOOT_SYSTEM}" soc)
  fi
  PKG_SOC=${PKG_SOC:-${DEVICE}}

  PKG_BOOT_INI="RKBOOT/${PKG_SOC}MINIALL.ini"
  if [ ! -f "${PKG_BOOT_INI}" ]; then
    PKG_BOOT_INI="RKBOOT/${DEVICE}MINIALL.ini"
  fi
  if [ -f "${PKG_BOOT_INI}" ]; then
    PKG_FILE=$(sed -nr "/^\[LOADER_OPTION\]/ { :l /^FlashData[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "${PKG_BOOT_INI}")
    if [ -f "${PKG_FILE}" ]; then
      cp -av "${PKG_FILE}" ddr.bin

      # Override sdram frequency
      if [ "${PKG_SOC}" = "RK3328" ]; then
        sed -s 's/\x4d\x1\x4d\x1\x4d\x1\x4d\x1\x4d\x1\x4d\x1/\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3/g' -i ddr.bin
        sed -s 's/\x90\x1\x90\x1\x90\x1\x90\x1\x90\x1\x90\x1/\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3/g' -i ddr.bin
      fi
    fi
  fi

  PKG_TRUST_INI="RKTRUST/${PKG_SOC}TRUST.ini"
  if [ ! -f "${PKG_TRUST_INI}" ]; then
    PKG_TRUST_INI="RKTRUST/${DEVICE}TRUST.ini"
  fi
  if [ -f "${PKG_TRUST_INI}" ]; then
    PKG_FILE=$(sed -nr "/^\[BL31_OPTION\]/ { :l /^PATH[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "${PKG_TRUST_INI}")
    if [ -f "${PKG_FILE}" ]; then
      cp -av "${PKG_FILE}" bl31.elf
    fi
  fi
}

makeinstall_target() {
  mkdir -p "${INSTALL}/.noinstall"
  for PKG_FILE in ddr.bin bl31.elf; do
    if [ -f "${PKG_FILE}" ]; then
      cp -av "${PKG_FILE}" "${INSTALL}/.noinstall"
    fi
  done
}
