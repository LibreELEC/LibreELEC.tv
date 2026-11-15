# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

[ -z "${SYSTEM_ROOT}" ] && SYSTEM_ROOT=""
[ -z "${BOOT_ROOT}" ] && BOOT_ROOT="/flash"
[ -z "${BOOT_PART}" ] && BOOT_PART=$(df "${BOOT_ROOT}" | tail -1 | awk {' print $1 '})
if [ -z "${BOOT_DISK}" ]; then
  case ${BOOT_PART} in
    /dev/sd[a-z][0-9]*)
      BOOT_DISK=$(echo ${BOOT_PART} | sed -e "s,[0-9]*,,g")
      ;;
    /dev/mmcblk*|/dev/nvme*)
      BOOT_DISK=$(echo ${BOOT_PART} | sed -e "s,p[0-9]*,,g")
      ;;
  esac
fi

# mount ${BOOT_ROOT} r/w
  mount -o remount,rw ${BOOT_ROOT}

# update device tree blobs
  if [ -d ${BOOT_ROOT}/starfive ]; then
    echo -n "Updating Device Tree Blobs... "
    for dtb in ${SYSTEM_ROOT}/usr/share/bootloader/jh7110*.dtb; do
      [ -f "${dtb}" ] && cp -p "${dtb}" ${BOOT_ROOT}/starfive
    done
    # mainline U-Boot name -> vendor kernel name (JH7110S, VisionFive 2 Lite)
    for dtb in starfive-visionfive-2-lite starfive-visionfive-2-lite-emmc; do
      [ -f ${SYSTEM_ROOT}/usr/share/bootloader/jh7110s-${dtb}.dtb ] &&
        cp -p ${SYSTEM_ROOT}/usr/share/bootloader/jh7110s-${dtb}.dtb ${BOOT_ROOT}/starfive/jh7110-${dtb}.dtb
    done
    echo "done"
  fi

# update the SPI flash bootloader files; they are only written to the flash
# by hand (flash-spi.scr)
  if [ -d ${BOOT_ROOT}/spi ]; then
    echo -n "Updating SPI flash bootloader files... "
    for f in u-boot-spl.bin.normal.out u-boot.itb flash-spi.scr; do
      [ -f ${SYSTEM_ROOT}/usr/share/bootloader/${f} ] && cp -p ${SYSTEM_ROOT}/usr/share/bootloader/${f} ${BOOT_ROOT}/spi
    done
    echo "done"
  fi

# update bootloader and boot.scr, only on a disk with the LibreELEC layout
# (GPT 3 "boot" at sector 16384, GPT 4 "uboot" at 8192, GPT 5 "spl" at 4096).
# This runs from the initramfs during an update, which has no parted or
# mktemp: check the partitions in sysfs.
  case ${BOOT_DISK} in
    /dev/mmcblk*|/dev/nvme*) PART_PREFIX="${BOOT_DISK}p" ;;
    *) PART_PREFIX="${BOOT_DISK}" ;;
  esac

  # <number> <start sector> <GPT name>
  is_part() {
    local sysfs="/sys/class/block/${PART_PREFIX##*/}${1}"

    [ "$(cat ${sysfs}/start 2>/dev/null)" = "${2}" ] &&
      grep -q "^PARTNAME=${3}$" ${sysfs}/uevent 2>/dev/null
  }

  if [ -n "${BOOT_DISK}" ]; then
    if [ -f ${SYSTEM_ROOT}/usr/share/bootloader/u-boot.itb ] &&
       is_part 4 8192 uboot && is_part 5 4096 spl; then
      echo -n "Updating U-Boot... "
      dd if=${SYSTEM_ROOT}/usr/share/bootloader/u-boot-spl.bin.normal.out of=${BOOT_DISK} bs=512 seek=4096 conv=fsync >/dev/null 2>&1
      dd if=${SYSTEM_ROOT}/usr/share/bootloader/u-boot.itb of=${BOOT_DISK} bs=512 seek=8192 conv=fsync >/dev/null 2>&1
      echo "done"
    fi
    if [ -f ${SYSTEM_ROOT}/usr/share/bootloader/boot.scr ] && is_part 3 16384 boot; then
      BOOT_SCR_MNT="/tmp/bootpart"
      mkdir -p ${BOOT_SCR_MNT}
      echo -n "Updating boot.scr... "
      if mount -t vfat ${PART_PREFIX}3 ${BOOT_SCR_MNT}; then
        for f in boot.scr vf2_uEnv.txt; do
          [ -f ${SYSTEM_ROOT}/usr/share/bootloader/${f} ] && cp ${SYSTEM_ROOT}/usr/share/bootloader/${f} ${BOOT_SCR_MNT}
        done
        umount ${BOOT_SCR_MNT}
        echo "done"
      else
        echo "failed"
      fi
    fi
  fi

# mount ${BOOT_ROOT} r/o
  sync
  mount -o remount,ro ${BOOT_ROOT}
