#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Install the LE overlay onto a live Variscite SD root.
# Copies KERNEL, SYSTEM, INITRD, DTB, and boot.scr, then fixes scriptaddr.
# Does not touch eMMC boot partitions or overwrite /boot/Image.gz.

set -euo pipefail

BOARD="${1:-root@192.168.1.16}"
DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="$(cd "${DEVICE_DIR}/../../../.." && pwd)"
TARGET_IMG="${TARGET_IMG:-${LE_ROOT}/target}"
DTB_NAME="imx8mp-var-dart-dt8mcustomboard.dtb"

SSH=(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null)
SCP=(scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null)

"${DEVICE_DIR}/scripts/stage-overlay.sh"

latest="$(ls -t "${TARGET_IMG}"/LibreELEC-VAR-DART-IMX8MP*.kernel 2>/dev/null | head -1 || true)"
if [[ -z "${latest}" ]]; then
  echo "no LibreELEC-VAR-DART-IMX8MP*.kernel in ${TARGET_IMG}" >&2
  exit 1
fi
IMAGE_NAME="$(basename "${latest}" .kernel)"

KERNEL="${TARGET_IMG}/${IMAGE_NAME}.kernel"
SYSTEM="${TARGET_IMG}/${IMAGE_NAME}.system"
INITRD="${TARGET_IMG}/${IMAGE_NAME}.initrd"
DTB="${TARGET_IMG}/${IMAGE_NAME}.dtb"
BOOT_SCR="${TARGET_IMG}/${IMAGE_NAME}.boot.scr"

for f in "${KERNEL}" "${SYSTEM}" "${INITRD}" "${DTB}" "${BOOT_SCR}"; do
  if [[ ! -f "${f}" ]]; then
    echo "missing ${f} — run make system and pack-initrd.sh first" >&2
    exit 1
  fi
done

echo "Uploading ${IMAGE_NAME} to ${BOARD}"
"${SSH[@]}" "${BOARD}" 'mkdir -p /boot/libreelec'
"${SCP[@]}" "${KERNEL}" "${BOARD}:/boot/libreelec/KERNEL"
"${SCP[@]}" "${SYSTEM}" "${BOARD}:/boot/libreelec/SYSTEM"
"${SCP[@]}" "${INITRD}" "${BOARD}:/boot/libreelec/INITRD"
"${SCP[@]}" "${DTB}" "${BOARD}:/boot/libreelec/${DTB_NAME}"
"${SCP[@]}" "${BOOT_SCR}" "${BOARD}:/boot/boot.scr"

"${SSH[@]}" "${BOARD}" 'if [ ! -f /boot/u-boot-env.overlay.bak ]; then
  fw_printenv loadbootscript bootscript > /boot/u-boot-env.overlay.bak
fi
# BSP loads boot.scr to loadaddr then "source" — that is the kernel load
# address. Point it at scriptaddr so the script is not overwritten.
fw_setenv loadbootscript "load mmc \${mmcdev}:\${mmcpart} \${scriptaddr} \${bootdir}/\${bsp_script}"
fw_setenv bootscript "echo Running bootscript from mmc ...; source \${scriptaddr}"
echo "--- env ---"
fw_printenv loadbootscript bootscript scriptaddr
echo "--- files ---"
ls -l /boot/boot.scr /boot/Image.gz /boot/libreelec'

echo
echo "Done. Next reboot uses LibreELEC KERNEL + SYSTEM (Yocto Image.gz left in place)."
echo "Recovery: unplug SD (or boot eMMC). boot.scr is only on the SD /boot."
