#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Copy Variscite imx-boot off the live board. Does not build U-Boot.

set -euo pipefail

BOARD="${1:-root@192.168.1.16}"
DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${IMX_BOOT_OUT:-${DEVICE_DIR}/vendor/imx-boot/imx-boot}"
SRC="${IMX_BOOT_SRC:-sd}"

SSH=(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null)

mkdir -p "$(dirname "${OUT}")"

case "${SRC}" in
  sd)
    echo "Dumping SD user-area imx-boot (32 KiB offset) from ${BOARD}"
    "${SSH[@]}" "${BOARD}" 'dd if=/dev/mmcblk1 bs=1k skip=32 count=4096 status=none' >"${OUT}"
    ;;
  emmc-boot0)
    echo "Dumping eMMC boot0 imx-boot from ${BOARD}"
    "${SSH[@]}" "${BOARD}" 'echo 0 > /sys/block/mmcblk2boot0/force_ro
dd if=/dev/mmcblk2boot0 bs=1k skip=0 count=4096 status=none' >"${OUT}"
    ;;
  *)
    echo "IMX_BOOT_SRC must be sd or emmc-boot0" >&2
    exit 1
    ;;
esac

chmod 0644 "${OUT}"
echo "Wrote ${OUT} ($(wc -c <"${OUT}") bytes)"
# HAB/IVT tag is 0xD1 at offset 0x400 on i.MX8M SD images (32 KiB skipped).
if ! LC_ALL=C grep -a -q $'\xd1' "${OUT}"; then
  echo "warning: no IVT-like 0xD1 byte found; check skip/offset" >&2
fi
