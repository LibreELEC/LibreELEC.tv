#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Kodi's install stamp does not hash devices/$DEVICE/kodi/*. Changing
# appliance.xml therefore does not rebuild kodi, and make system copies
# the stale install_pkg tree (appliance-gbm default 0).
# Merge the device appliance onto the image copy after packages, before squashfs.

set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LE_ROOT="${ROOT:-$(cd "${DEVICE_DIR}/../../../.." && pwd)}"
BUILD="${BUILD:-${LE_ROOT}/build.LibreELEC-VAR-DART-IMX8MP.aarch64-13.0-devel}"
DEVICE_APPLIANCE="${DEVICE_DIR}/kodi/appliance.xml"
MERGE="${LE_ROOT}/packages/mediacenter/kodi/scripts/xml_merge.py"
IMG_ROOT="${INSTALL:-${BUILD}/image/system}"
APPLIANCE="${IMG_ROOT}/usr/share/kodi/system/settings/appliance.xml"

if [[ ! -f "${DEVICE_APPLIANCE}" ]]; then
  echo "pre-squash: no ${DEVICE_APPLIANCE}" >&2
  exit 0
fi
if [[ ! -f "${APPLIANCE}" ]]; then
  echo "pre-squash: no image appliance.xml at ${APPLIANCE}" >&2
  exit 0
fi

python3 "${MERGE}" "${APPLIANCE}" "${DEVICE_APPLIANCE}" >"${APPLIANCE}.new"
mv "${APPLIANCE}.new" "${APPLIANCE}"
echo "pre-squash: merged ${DEVICE_APPLIANCE} -> ${APPLIANCE}"
grep -A1 'useprimerenderer' "${APPLIANCE}" || true
