#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Build a Variscite-sized MMC env image (CRC32 + 0x4000).

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${ENV_TXT:-${DEVICE_DIR}/scripts/uboot-env.txt}"
OUT="${1:-${DEVICE_DIR}/vendor/imx-boot/uboot.env}"

if ! command -v mkenvimage >/dev/null; then
  echo "mkenvimage not found (Debian: u-boot-tools)" >&2
  exit 1
fi
if [ ! -f "${SRC}" ]; then
  echo "missing ${SRC}" >&2
  exit 1
fi

mkdir -p "$(dirname "${OUT}")"
# Strip comments/blank lines; mkenvimage wants key=value only.
TMP="$(mktemp)"
trap 'rm -f "${TMP}"' EXIT
grep -vE '^[[:space:]]*(#|$)' "${SRC}" >"${TMP}"

mkenvimage -s 0x4000 -o "${OUT}" "${TMP}"
chmod 0644 "${OUT}"
echo "Wrote ${OUT} ($(wc -c <"${OUT}") bytes)"
