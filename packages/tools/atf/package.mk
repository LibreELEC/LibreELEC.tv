# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC

PKG_NAME="atf"
PKG_VERSION="2.15.0"
PKG_SHA256="67b772aaa58218712c062ccd103f1d53cf74d9543e251f20ac037a6dbf821a10"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/ARM-software/arm-trusted-firmware"
PKG_URL="https://github.com/TrustedFirmware-A/trusted-firmware-a/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ARM Trusted Firmware is a reference implementation of secure world software, including a Secure Monitor executing at Exception Level 3 and various Arm interface standards."
PKG_TOOLCHAIN="manual"

[ -n "${KERNEL_TOOLCHAIN}" ] && PKG_DEPENDS_TARGET+=" gcc-${KERNEL_TOOLCHAIN}:host"

if [ "${ATF_PLATFORM}" = "rk3399" ]; then
  PKG_DEPENDS_TARGET+=" gcc-arm-none-eabi:host"
  export M0_CROSS_COMPILE="${TOOLCHAIN}/bin/arm-none-eabi-"
fi

make_target() {
  # As of atf 2.11.0 - the supported compile for .S is gcc (not as.)
  unset AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP STRIP RANLIB
  unset CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
  if [ "${ATF_PLATFORM}" = "imx8mq" ]; then
    CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" make PLAT=${ATF_PLATFORM} LOG_LEVEL=0 bl31
  elif [ "${ATF_PLATFORM}" = "imx8mp" ]; then
    # DART-MX8MP: UART1 (ttymxc0) + OP-TEE dispatcher. BL32_BASE is 0x56000000
    # in plat/imx/imx8m/imx8mp (matches imx-mkimage TEE_LOAD_ADDR).
    CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" make PLAT=${ATF_PLATFORM} IMX_BOOT_UART_BASE=0x30860000 SPD=opteed LOG_LEVEL=40 bl31
  else
    # as of atf 2.12.0 - sun50i_a64 builds use LTO, include -ffat-lto-objects to support this
    CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" CFLAGS="-ffat-lto-objects" make PLAT=${ATF_PLATFORM} bl31
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  cp -a build/${ATF_PLATFORM}/release/${ATF_BL31_BINARY:-bl31.bin} ${INSTALL}/usr/share/bootloader
}
