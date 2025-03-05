# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC

PKG_NAME="atf"
PKG_VERSION="2.12.0"
PKG_SHA256="d95aaf292792c98035910d7e6c64ebfb297c897fef510415db1612f6d39f9223"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3c"
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
  else
    # as of atf 2.12.0 - sun50i_a64 builds use LTO, include -ffat-lto-objects to support this
    CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" CFLAGS="-ffat-lto-objects" make PLAT=${ATF_PLATFORM} bl31
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  cp -a build/${ATF_PLATFORM}/release/${ATF_BL31_BINARY:-bl31.bin} ${INSTALL}/usr/share/bootloader
}
