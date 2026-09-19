#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Check a make-image .img: msdos, FAT start >= 16 MiB, labels LIBREELEC + STORAGE.

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="${ROOT:-$(cd "${DEVICE_DIR}/../../../.." && pwd)}"
TARGET_IMG="${TARGET_IMG:-${LE_ROOT}/target}"

IMG="${1:-}"
if [ -z "${IMG}" ]; then
  IMG="$(ls -t "${TARGET_IMG}"/LibreELEC-VAR-DART-IMX8MP*.img 2>/dev/null | head -1 || true)"
fi
if [ -z "${IMG}" ] && [ -f "${TARGET_IMG}/uuu-emmc/image.img" ]; then
  IMG="${TARGET_IMG}/uuu-emmc/image.img"
fi
if [ -z "${IMG}" ]; then
  echo "no image given or found" >&2
  exit 1
fi
if [[ "${IMG}" == *.gz ]]; then
  echo "pass an uncompressed .img (or pack-uuu-bundle.sh first)" >&2
  exit 1
fi

echo "Checking ${IMG}"
sfdisk -d "${IMG}"

python3 - "${IMG}" <<'PY'
import binascii, struct, sys
path = sys.argv[1]
with open(path, "rb") as f:
    f.seek(0x700000)
    blob = f.read(0x4000)
if len(blob) != 0x4000:
    raise SystemExit("FAIL: short read at 0x700000")
crc, data = struct.unpack_from("<I", blob, 0)[0], blob[4:]
got = binascii.crc32(data) & 0xFFFFFFFF
if crc == 0 and data == b"\x00" * len(data):
    raise SystemExit("FAIL: no uboot.env at 0x700000 (re-run pack-uuu-bundle.sh)")
if crc != got:
    raise SystemExit(f"FAIL: env CRC 0x{crc:08x} != computed 0x{got:08x}")
text = data.split(b"\x00\x00", 1)[0].decode("ascii", "replace")
if "scriptaddr" not in text or "loadbootscript" not in text:
    raise SystemExit("FAIL: env at 0x700000 missing loadbootscript/scriptaddr")
print("ok uboot.env at 0x700000 (CRC match)")
PY

START="$(sfdisk -d "${IMG}" | awk '/start=/{print $4; exit}' | tr -d ',')"
if [ -z "${START}" ] || [ "${START}" -lt 32768 ]; then
  echo "FAIL: first partition start ${START:-unset} (want >= 32768)" >&2
  exit 1
fi

LOOP="$(losetup -f --show -P "${IMG}")"
trap 'losetup -d "${LOOP}"' EXIT
sleep 0.2

P1="${LOOP}p1"
P2="${LOOP}p2"
FAT_LABEL="$(blkid -s LABEL -o value "${P1}" || true)"
EXT_LABEL="$(blkid -s LABEL -o value "${P2}" || true)"
echo "p1 LABEL=${FAT_LABEL} TYPE=$(blkid -s TYPE -o value "${P1}" || true)"
echo "p2 LABEL=${EXT_LABEL} TYPE=$(blkid -s TYPE -o value "${P2}" || true)"

fail=0
[ "${FAT_LABEL}" = "LIBREELEC" ] || { echo "FAIL: p1 label is '${FAT_LABEL}'"; fail=1; }
[ "${EXT_LABEL}" = "STORAGE" ] || { echo "FAIL: p2 label is '${EXT_LABEL}'"; fail=1; }

MNT="$(mktemp -d)"
trap 'umount "${MNT}" 2>/dev/null || true; rmdir "${MNT}"; losetup -d "${LOOP}"' EXIT
mount -o ro "${P1}" "${MNT}"
for f in KERNEL SYSTEM INITRD boot.scr boot/boot.scr imx8mp-var-dart-dt8mcustomboard.dtb; do
  if [ ! -e "${MNT}/${f}" ]; then
    echo "FAIL: missing /flash/${f}"
    fail=1
  else
    echo "ok ${f} ($(stat -c%s "${MNT}/${f}") bytes)"
  fi
done
umount "${MNT}"

if [ "${fail}" -ne 0 ]; then
  exit 1
fi
echo "PASS"
