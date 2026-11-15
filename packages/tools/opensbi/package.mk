# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="opensbi"
PKG_VERSION="1.8.1"
PKG_SHA256="fb1ae61a85e966322101acb1c982f84d9eaafc4de7dd474a7d7546d9bb321c6f"
PKG_ARCH="riscv64"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://github.com/riscv-software-src/opensbi"
PKG_URL="https://github.com/riscv-software-src/opensbi/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="OpenSBI is the RISC-V Supervisor Binary Interface (SBI) reference implementation, the M-mode firmware below U-Boot and Linux."
PKG_TOOLCHAIN="manual"

[ -n "${KERNEL_TOOLCHAIN}" ] && PKG_DEPENDS_TARGET+=" gcc-${KERNEL_TOOLCHAIN}:host"

make_target() {
  # firmware build: no target userspace flags
  unset AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP STRIP RANLIB
  unset CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
  make CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" PLATFORM=${OPENSBI_PLATFORM:-generic} FW_PIC=y
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  cp -a build/platform/${OPENSBI_PLATFORM:-generic}/firmware/fw_dynamic.bin ${INSTALL}/usr/share/bootloader
}
