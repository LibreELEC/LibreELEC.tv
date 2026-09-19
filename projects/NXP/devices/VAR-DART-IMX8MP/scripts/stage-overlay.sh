#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Publish DTB + boot.scr (+ INITRD) next to .kernel/.system so the upload
# set is visible under target/. Called from scripts/image after make system,
# or standalone after the fact.

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="${ROOT:-$(cd "${DEVICE_DIR}/../../../.." && pwd)}"
DTB_NAME="imx8mp-var-dart-dt8mcustomboard.dtb"
BOOT_CMD="${DEVICE_DIR}/bootloader/boot.cmd"
TARGET_IMG="${TARGET_IMG:-${LE_ROOT}/target}"

if [[ -z "${IMAGE_NAME:-}" ]]; then
  latest="$(ls -t "${TARGET_IMG}"/LibreELEC-VAR-DART-IMX8MP*.kernel 2>/dev/null | head -1 || true)"
  if [[ -z "${latest}" ]]; then
    echo "no LibreELEC-VAR-DART-IMX8MP*.kernel in ${TARGET_IMG}" >&2
    exit 1
  fi
  IMAGE_NAME="$(basename "${latest}" .kernel)"
fi

find_dtb() {
  local candidates=(
    "${BUILD:+${BUILD}/build/linux-*/arch/arm64/boot/dts/freescale/${DTB_NAME}}"
    "${LE_ROOT}/build.LibreELEC-VAR-DART-IMX8MP.aarch64-13.0-devel/build/linux-*/arch/arm64/boot/dts/freescale/${DTB_NAME}"
    "${DEVICE_DIR}/vendor/dtb/${DTB_NAME}"
    "${BUILD:+${BUILD}/image/system/usr/share/bootloader/${DTB_NAME}}"
    "${LE_ROOT}/build.LibreELEC-VAR-DART-IMX8MP.aarch64-13.0-devel/image/system/usr/share/bootloader/${DTB_NAME}"
  )
  local path
  for path in "${candidates[@]}"; do
    [[ -z "${path}" ]] && continue
    # expand a single glob if present
    if [[ "${path}" == *'*'* ]]; then
      path="$(ls ${path} 2>/dev/null | head -1 || true)"
    fi
    if [[ -n "${path}" && -f "${path}" ]]; then
      echo "${path}"
      return 0
    fi
  done
  return 1
}

if [[ ! -f "${BOOT_CMD}" ]]; then
  echo "missing ${BOOT_CMD}" >&2
  exit 1
fi

DTB="$(find_dtb || true)"
if [[ -z "${DTB}" ]]; then
  echo "missing ${DTB_NAME} (build linux first)" >&2
  exit 1
fi

MKIMAGE=""
if [[ -n "${TOOLCHAIN:-}" && -x "${TOOLCHAIN}/bin/mkimage" ]]; then
  MKIMAGE="${TOOLCHAIN}/bin/mkimage"
elif command -v mkimage >/dev/null; then
  MKIMAGE="$(command -v mkimage)"
else
  echo "mkimage not found (u-boot-tools)" >&2
  exit 1
fi

mkdir -p "${TARGET_IMG}" "${DEVICE_DIR}/vendor/dtb" "${DEVICE_DIR}/bootloader"

cp -f "${DTB}" "${TARGET_IMG}/${IMAGE_NAME}.dtb"
cp -f "${DTB}" "${DEVICE_DIR}/vendor/dtb/${DTB_NAME}"
chmod 0644 "${TARGET_IMG}/${IMAGE_NAME}.dtb"

"${MKIMAGE}" -A arm64 -O linux -T script -C none \
  -n "VAR-DART-IMX8MP hybrid" \
  -d "${BOOT_CMD}" "${TARGET_IMG}/${IMAGE_NAME}.boot.scr" >/dev/null
cp -f "${TARGET_IMG}/${IMAGE_NAME}.boot.scr" "${DEVICE_DIR}/bootloader/boot.scr"
chmod 0644 "${TARGET_IMG}/${IMAGE_NAME}.boot.scr"

INITRD="${DEVICE_DIR}/vendor/INITRD"
if [[ -f "${INITRD}" ]]; then
  cp -f "${INITRD}" "${TARGET_IMG}/${IMAGE_NAME}.initrd"
  chmod 0644 "${TARGET_IMG}/${IMAGE_NAME}.initrd"
fi

cat > "${TARGET_IMG}/${IMAGE_NAME}.overlay" <<EOF
LibreELEC overlay upload set (${IMAGE_NAME})

  ${IMAGE_NAME}.kernel   -> /boot/libreelec/KERNEL
  ${IMAGE_NAME}.system   -> /boot/libreelec/SYSTEM
  ${IMAGE_NAME}.initrd   -> /boot/libreelec/INITRD
  ${IMAGE_NAME}.dtb      -> /boot/libreelec/${DTB_NAME}
  ${IMAGE_NAME}.boot.scr -> /boot/boot.scr

Do not overwrite /boot/Image.gz (Yocto kernel).
Install: projects/NXP/devices/VAR-DART-IMX8MP/scripts/install-sd-overlay.sh
EOF

echo "DTB source: ${DTB}"
echo "Staged overlay artifacts:"
ls -l "${TARGET_IMG}/${IMAGE_NAME}".{kernel,system,dtb,boot.scr,initrd,overlay} 2>/dev/null || \
  ls -l "${TARGET_IMG}/${IMAGE_NAME}".dtb "${TARGET_IMG}/${IMAGE_NAME}.boot.scr"
