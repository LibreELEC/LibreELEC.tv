#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Assemble target/uuu-emmc/ for: sudo uuu uuu.auto

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="${ROOT:-$(cd "${DEVICE_DIR}/../../../.." && pwd)}"
TARGET_IMG="${TARGET_IMG:-${LE_ROOT}/target}"
BUNDLE="${BUNDLE:-${TARGET_IMG}/uuu-emmc}"
VENDOR_IMX="${DEVICE_DIR}/vendor/imx-boot"

IMX=""
if [ -s "${VENDOR_IMX}/imx-boot" ]; then
  IMX="${VENDOR_IMX}/imx-boot"
elif [ -s "${VENDOR_IMX}/imx-boot-sd.bin" ]; then
  IMX="${VENDOR_IMX}/imx-boot-sd.bin"
elif [ -s "${VENDOR_IMX}/flash.bin" ]; then
  IMX="${VENDOR_IMX}/flash.bin"
fi
if [ -z "${IMX}" ]; then
  echo "missing vendor imx-boot (see ${VENDOR_IMX}/README.md)" >&2
  exit 1
fi

IMG=""
if [ -n "${IMAGE_NAME:-}" ] && [ -f "${TARGET_IMG}/${IMAGE_NAME}.img" ]; then
  IMG="${TARGET_IMG}/${IMAGE_NAME}.img"
elif [ -n "${IMAGE_NAME:-}" ] && [ -f "${TARGET_IMG}/${IMAGE_NAME}.img.gz" ]; then
  IMG="${TARGET_IMG}/${IMAGE_NAME}.img.gz"
else
  IMG="$(ls -t "${TARGET_IMG}"/LibreELEC-VAR-DART-IMX8MP*.img 2>/dev/null | head -1 || true)"
  if [ -z "${IMG}" ]; then
    IMG="$(ls -t "${TARGET_IMG}"/LibreELEC-VAR-DART-IMX8MP*.img.gz 2>/dev/null | head -1 || true)"
  fi
fi
if [ -z "${IMG}" ]; then
  echo "no LibreELEC-VAR-DART-IMX8MP*.img(.gz) in ${TARGET_IMG} — run make image" >&2
  exit 1
fi

rm -rf "${BUNDLE}"
mkdir -p "${BUNDLE}"
cp -a "${IMX}" "${BUNDLE}/imx-boot"
cp -a "${DEVICE_DIR}/scripts/uuu.auto" "${BUNDLE}/uuu.auto"
cp -a "${DEVICE_DIR}/scripts/uuu-env.auto" "${BUNDLE}/uuu-env.auto"

if [[ "${IMG}" == *.gz ]]; then
  echo "Decompressing $(basename "${IMG}")"
  gzip -dc "${IMG}" >"${BUNDLE}/image.img"
else
  cp -a "${IMG}" "${BUNDLE}/image.img"
fi

"${DEVICE_DIR}/scripts/mk-uboot-env.sh" "${BUNDLE}/uboot.env"
# Inject env into the 16 MiB gap (0x700000). saveenv over SDP cannot.
dd if="${BUNDLE}/uboot.env" of="${BUNDLE}/image.img" bs=1 seek="$((0x700000))" conv=notrunc status=none
echo "Injected uboot.env at image offset 0x700000"

if command -v bmaptool >/dev/null; then
  bmaptool create -o "${BUNDLE}/image.img.bmap" "${BUNDLE}/image.img" || true
fi

cat >"${BUNDLE}/README" <<EOF
LibreELEC VAR-DART-IMX8MP UUU eMMC bundle

1. Dip-switch to SD boot, remove the SD card, connect USB OTG.
2. Power on. Host should see an NXP SDP device.
3. sudo uuu uuu.auto
4. Dip-switch to eMMC and reboot.

This replaces the Yocto eMMC image, including boot0.
SD overlay (or a Yocto SD) is the recovery path.

If a previous run failed only on saveenv, flash just the env:
  sudo uuu uuu-env.auto

imx-boot: ${IMX}
image:    ${IMG}
EOF

chmod 0644 "${BUNDLE}/imx-boot" "${BUNDLE}/image.img" "${BUNDLE}/uuu.auto" "${BUNDLE}/uuu-env.auto" "${BUNDLE}/uboot.env"
echo "UUU bundle: ${BUNDLE}"
ls -lh "${BUNDLE}"
