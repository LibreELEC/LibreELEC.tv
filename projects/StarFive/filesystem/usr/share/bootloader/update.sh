# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

[ -z "${SYSTEM_ROOT}" ] && SYSTEM_ROOT=""
[ -z "${BOOT_ROOT}" ] && BOOT_ROOT="/flash"

# mount ${BOOT_ROOT} r/w
  mount -o remount,rw ${BOOT_ROOT}

# update device tree blobs
  if [ -d ${BOOT_ROOT}/starfive ]; then
    echo -n "Updating Device Tree Blobs... "
    for dtb in ${SYSTEM_ROOT}/usr/share/bootloader/jh7110*.dtb; do
      [ -f "${dtb}" ] && cp -p "${dtb}" ${BOOT_ROOT}/starfive
    done
    echo "done"
  fi

# mount ${BOOT_ROOT} r/o
  sync
  mount -o remount,ro ${BOOT_ROOT}
