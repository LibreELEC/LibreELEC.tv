#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Pack LibreELEC build/initramfs into a standalone INITRD for option A.
# The kernel initramfs.conf merged-usr links are not in the directory tree;
# they must be added here or /init (#!/bin/sh) fails with ENOENT.

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="$(cd "${DEVICE_DIR}/../../../.." && pwd)"
BUILD="${LE_ROOT}/build.LibreELEC-VAR-DART-IMX8MP.aarch64-13.0-devel"
SRC="${BUILD}/initramfs"
OUT="${1:-${DEVICE_DIR}/vendor/INITRD}"

if [[ ! -x "${SRC}/init" || ! -e "${SRC}/usr/bin/busybox" ]]; then
  echo "incomplete initramfs at ${SRC}" >&2
  exit 1
fi

STAGE=$(mktemp -d)
trap 'rm -rf "${STAGE}"' EXIT

cp -a "${SRC}/." "${STAGE}/"
# Same slinks as packages/virtual/initramfs/config/initramfs.conf
ln -sfn usr/bin "${STAGE}/bin"
ln -sfn usr/sbin "${STAGE}/sbin"
ln -sfn usr/lib "${STAGE}/lib"
mkdir -p "${STAGE}/dev"

mkdir -p "$(dirname "${OUT}")"
( cd "${STAGE}" && find . | cpio -o -H newc --quiet --owner=0:0 | gzip -9 ) > "${OUT}"
echo "Wrote ${OUT} ($(du -h "${OUT}" | awk '{print $1}'))"
