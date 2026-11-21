# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="rtw88-rtl8723bs"
PKG_VERSION="0f64b72d8ec091d811a1a44f8b314e9df1b72d78"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/MocLG/rtw88-rtl8723bs"

PKG_URL="https://github.com/MocLG/rtw88-rtl8723bs/archive/${PKG_VERSION}.tar.gz"

PKG_LONGDESC="Realtek RTL8723BS SDIO WiFi driver using the rtw88 framework"

# This package requires the LibreELEC kernel build environment.
PKG_IS_KERNEL_PKG="yes"

PKG_DEPENDS_TARGET="toolchain linux"

# The repository contains its own Makefile and Kbuild definitions.

make_target() {
  kernel_make \
    -C "${PKG_BUILD}" \
    KSRC="$(kernel_path)" \
    KVER="$(get_module_dir)" \
    JOBS="${CONCURRENCY_MAKE_LEVEL}"
}

makeinstall_target() {
  local module_dir
  local firmware_dir

  module_dir="${INSTALL}/$(get_full_module_dir)/updates/rtw88"
  firmware_dir="${INSTALL}/$(get_full_firmware_dir)/rtw88"

  mkdir -p "${module_dir}"
  mkdir -p "${firmware_dir}"

  # Install the compiled kernel modules.
  for module in \
    rtw_core \
    rtw_8723x \
    rtw_8723b \
    rtw_8723bs \
    rtw_sdio
  do
    install -m 0644 \
      "${PKG_BUILD}/${module}.ko" \
      "${module_dir}/${module}.ko"
  done

  # Install firmware.
  install -m 0644 \
    "${PKG_BUILD}/firmware/rtw8723b_fw.bin" \
    "${firmware_dir}/rtw8723b_fw.bin"
}
