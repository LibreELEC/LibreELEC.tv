# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Variscite lf_v2025.04 U-Boot (imx8mp_var_dart). flash.bin is assembled
# with varigit imx-mkimage iMX8M (SOC=iMX8MP flash_evk), not U-Boot's
# in-tree imx8mimage and not iMX8QX.

PKG_NAME="u-boot"
PKG_VERSION="177ee80607234c488daf9cda8bbefb25b7e5b7a5"
PKG_SHA256="79d1cfe681d542b1428d7a2583f990c6ae73f495151f024fddea8497805d59cf"
PKG_ARCH="aarch64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/sigysmund/uboot-imx"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl:host pkg-config:host Python3:host swig:host pyelftools:host zlib:host"
PKG_LONGDESC="Variscite U-Boot for DART-MX8MP. flash.bin via imx-mkimage iMX8M / SOC=iMX8MP."

PKG_STAMP="${UBOOT_SYSTEM} ${UBOOT_TARGET}"

[ -n "${KERNEL_TOOLCHAIN}" ] && PKG_DEPENDS_TARGET+=" gcc-${KERNEL_TOOLCHAIN}:host"

if [ -n "${UBOOT_FIRMWARE}" ]; then
  PKG_DEPENDS_TARGET+=" ${UBOOT_FIRMWARE}"
  PKG_DEPENDS_UNPACK+=" ${UBOOT_FIRMWARE}"
fi

PKG_NEED_UNPACK="${PROJECT_DIR}/${PROJECT}/bootloader"
[ -n "${DEVICE}" ] && PKG_NEED_UNPACK+=" ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/bootloader"
[ -n "${DEVICE}" ] && PKG_NEED_UNPACK+=" ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/patches/${PKG_NAME}"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}

post_patch() {
  if [ -n "${UBOOT_SYSTEM}" ] && find_file_path bootloader/config; then
    PKG_CONFIG_FILE="${PKG_BUILD}/configs/$(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} config)"
    if [ -f "${PKG_CONFIG_FILE}" ]; then
      cat ${FOUND_PATH} >>"${PKG_CONFIG_FILE}"
    fi
  fi
}

# i.MX8MP LPDDR4 training bins expected by iMX8M/soc.mak (LPDDR_FW_VERSION=_202006).
_imx8mp_lpddr_bins() {
  echo \
    lpddr4_pmu_train_1d_imem_202006.bin \
    lpddr4_pmu_train_1d_dmem_202006.bin \
    lpddr4_pmu_train_2d_imem_202006.bin \
    lpddr4_pmu_train_2d_dmem_202006.bin
}

_assemble_imx8m_flash() {
  local mk_dir fw_dir dtb_name dtb_src bin f
  mk_dir="$(get_build_dir imx-mkimage)/iMX8M"
  fw_dir="$(get_build_dir firmware-imx)/firmware/ddr/synopsys"
  dtb_name="$(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} dtb)"

  [ -d "${mk_dir}" ] || { echo "imx-mkimage iMX8M missing: ${mk_dir}"; exit 1; }

  for bin in u-boot.bin u-boot-nodtb.bin spl/u-boot-spl.bin tools/mkimage; do
    [ -f "${bin}" ] || { echo "missing U-Boot output ${bin}"; exit 1; }
  done

  dtb_src=""
  for f in \
    "arch/arm/dts/${dtb_name}" \
    "dts/upstream/src/arm64/freescale/${dtb_name}" \
    "${dtb_name}"; do
    if [ -f "${f}" ]; then
      dtb_src="${f}"
      break
    fi
  done
  [ -n "${dtb_src}" ] || { echo "missing U-Boot DTB ${dtb_name}"; exit 1; }

  cp -av spl/u-boot-spl.bin "${mk_dir}/"
  cp -av u-boot.bin u-boot-nodtb.bin "${mk_dir}/"
  cp -av tools/mkimage "${mk_dir}/mkimage_uboot"
  # mkimage was built with CONFIG_MKIMAGE_DTC_PATH=scripts/dtc/dtc (relative).
  [ -x scripts/dtc/dtc ] || { echo "missing U-Boot host dtc at scripts/dtc/dtc"; exit 1; }
  mkdir -p "${mk_dir}/scripts/dtc"
  ln -sfn "${PKG_BUILD}/scripts/dtc/dtc" "${mk_dir}/scripts/dtc/dtc"
  cp -av "$(get_install_dir atf)/usr/share/bootloader/bl31.bin" "${mk_dir}/"
  cp -av "$(get_install_dir optee-os)/usr/share/bootloader/tee.bin" "${mk_dir}/tee.bin"
  cp -av "${dtb_src}" "${mk_dir}/${dtb_name}"

  for f in $(_imx8mp_lpddr_bins); do
    [ -f "${fw_dir}/${f}" ] || { echo "missing ${fw_dir}/${f}"; exit 1; }
    cp -av "${fw_dir}/${f}" "${mk_dir}/"
  done

  # Compile iMX8M/mkimage_imx8.c (not src/mkimage_imx8.c — that is iMX8QX).
  # Drop -static so host zlib from the toolchain is enough.
  make -C "${mk_dir}" -f soc.mak \
    SOC=iMX8MP SOC_DIR=iMX8M \
    dtbs="${dtb_name}" \
    MKIMG=./mkimage_imx8 \
    MKIMAGE=./mkimage_uboot \
    PAD_IMAGE=../scripts/pad_image.sh \
    CC="${HOST_CC}" \
    CFLAGS="-O2 -Wall -std=c99 -I${TOOLCHAIN}/include" \
    BUILD_LDFLAGS="-L${TOOLCHAIN}/lib -lz" \
    OUTIMG=flash.bin \
    flash_evk

  cp -av "${mk_dir}/flash.bin" flash.bin
}

make_target() {
  setup_pkg_config_host
  if [ -z "${UBOOT_SYSTEM}" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
    exit 1
  fi
  [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
  DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make mrproper
  [ -n "${UBOOT_FIRMWARE}" ] && find_file_path bootloader/firmware && . ${FOUND_PATH}
  DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" $(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} config)
  # Binaries only. flash.bin comes from imx-mkimage iMX8M, not `make flash.bin`.
  DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
  _assemble_imx8m_flash
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader

  if [ -n "${UBOOT_SYSTEM}" ]; then
    find_file_path bootloader/install && . ${FOUND_PATH}
  fi

  find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

  if find_file_path bootloader/canupdate.sh; then
    cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
      -i ${INSTALL}/usr/share/bootloader/canupdate.sh
  fi
}
