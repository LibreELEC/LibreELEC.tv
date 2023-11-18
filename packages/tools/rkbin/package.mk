# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"
PKG_VERSION="b0c100f1a260d807df450019774993c761beb79d"
PKG_SHA256="c6ebf8ab556e071e3b067540e95aecff650143f0c97e129cd40c837a4f11a881"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/rkbin"
PKG_URL="https://github.com/rockchip-linux/rkbin/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_STAMP="$UBOOT_SYSTEM"

make_target() {
  PKG_BOOT_INI="RKBOOT/${DEVICE}MINIALL.ini"
  if [ -f "${PKG_BOOT_INI}" ]; then
    PKG_FILE=$(sed -nr "/^\[LOADER_OPTION\]/ { :l /^FlashData[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "${PKG_BOOT_INI}")
    if [ -f "${PKG_FILE}" ]; then
      cp -av "${PKG_FILE}" ddr.bin

      # Override sdram frequency
      if [ "${DEVICE}" = "RK3328" ]; then
        sed -s 's/\x4d\x1\x4d\x1\x4d\x1\x4d\x1\x4d\x1\x4d\x1/\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3/g' -i ddr.bin
        sed -s 's/\x90\x1\x90\x1\x90\x1\x90\x1\x90\x1\x90\x1/\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3\x20\x3/g' -i ddr.bin
      fi
    fi
  fi

  PKG_TRUST_INI="RKTRUST/${DEVICE}TRUST.ini"
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
