# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

[ -z "${SYSTEM_ROOT}" ] && SYSTEM_ROOT=""
[ -z "${BOOT_ROOT}" ] && BOOT_ROOT="/flash"
[ -z "${BOOT_PART}" ] && BOOT_PART=$(df "${BOOT_ROOT}" | tail -1 | awk {' print $1 '})
if [ -z "${BOOT_DISK}" ]; then
  case ${BOOT_PART} in
    /dev/sd[a-z][0-9]*)
      BOOT_DISK=$(echo ${BOOT_PART} | sed -e "s,[0-9]*,,g")
      ;;
    /dev/mmcblk*)
      BOOT_DISK=$(echo ${BOOT_PART} | sed -e "s,p[0-9]*,,g")
      ;;
  esac
fi

# mount ${BOOT_ROOT} r/w
  mount -o remount,rw ${BOOT_ROOT}

# update device tree
  for all_dtb in ${BOOT_ROOT}/*.dtb; do
    [ -f "$all_dtb" ] || continue
    dtb=$(basename ${all_dtb})

    # device tree mappings for update from vendor to mainline kernel
    case "${dtb}" in
      rk3288-miniarm.dtb)
        new_dtb=rk3288-tinker-s.dtb
        ;;
      rk3328-box.dtb|rk3328-box-trn9.dtb|rk3328-box-z28.dtb|rk3328-rockbox.dtb)
        new_dtb=rk3328-a1.dtb
        ;;
      rk3399-rock-pi-4.dtb)
        new_dtb=rk3399-rock-pi-4b.dtb
        ;;
      *)
        new_dtb="${dtb}"
        ;;
    esac

    if [ "${dtb}" != "${new_dtb}" -a -f ${SYSTEM_ROOT}/usr/share/bootloader/${new_dtb} ]; then
      echo -n "Replacing ${dtb} with ${new_dtb}... "
      cp -p ${SYSTEM_ROOT}/usr/share/bootloader/${new_dtb} ${BOOT_ROOT} && \
      sed -e "s/FDT \/${dtb}/FDT \/${new_dtb}/g" \
          -i ${BOOT_ROOT}/extlinux/extlinux.conf && \
      rm -f ${BOOT_ROOT}/${dtb}
      echo "done"
    else
      if [ -f ${SYSTEM_ROOT}/usr/share/bootloader/${dtb} ]; then
        echo -n "Updating ${dtb}... "
        cp -p ${SYSTEM_ROOT}/usr/share/bootloader/${dtb} ${BOOT_ROOT}
        echo "done"
      elif [ "$(grep -c "FDT /${dtb}" ${BOOT_ROOT}/extlinux/extlinux.conf)" -ne 0 ]; then
        non_existent_dtb="${dtb}"
      fi
    fi
  done

# update /rockchip device tree blobs
  if [ -d ${BOOT_ROOT}/rockchip ]; then
    echo -n "Updating Device Tree Blobs... "
    for all_dtb in ${BOOT_ROOT}/rockchip/*.dtb; do
      [ -f "$all_dtb" ] || continue
      dtb=$(basename ${all_dtb})
      if [ -f ${SYSTEM_ROOT}/usr/share/bootloader/${dtb} ]; then
        cp -p ${SYSTEM_ROOT}/usr/share/bootloader/${dtb} ${BOOT_ROOT}/rockchip
      fi
    done
    echo "done"
  fi

# update bootloader
  loader_sig() {
    dd if="${1}" bs=4 skip=8192 count=1 2>/dev/null | md5sum | awk '{print $1}'
  }

  if [ -f "${UPDATE_IMG_FILE}" -a -n "${UPDATE_IMG_OFFSET}" -a -b "${BOOT_DISK}" ]; then
    IMG_SIG=$(loader_sig "${UPDATE_IMG_FILE}")
    DISK_SIG=$(loader_sig "${BOOT_DISK}")
    ZERO_SIG=$(loader_sig /dev/zero)
    LOADER_END=$((UPDATE_IMG_OFFSET / 512))
    PART_START=$(cat /sys/class/block/$(basename ${BOOT_PART})/start 2>/dev/null)
    [ -n "${PART_START}" ] && [ "${PART_START}" -lt "${LOADER_END}" ] && LOADER_END=${PART_START}
    BOARD_COMPAT=$(tr '\0' '\n' </proc/device-tree/compatible 2>/dev/null | head -n 1)
  fi

  if [ -n "${IMG_SIG}" -a "${IMG_SIG}" != "${ZERO_SIG}" -a "${IMG_SIG}" = "${DISK_SIG}" ] && \
     ! dd if="${UPDATE_IMG_FILE}" bs=512 skip=64 count=$((LOADER_END - 64)) 2>/dev/null | \
       grep -aqF "${BOARD_COMPAT:-none}"; then
    echo "Skipping U-Boot update: image is not for ${BOARD_COMPAT:-this board}"
    IMG_SIG=""
  fi

  if [ -n "${IMG_SIG}" -a "${IMG_SIG}" != "${ZERO_SIG}" -a "${IMG_SIG}" = "${DISK_SIG}" ]; then
    echo -n "Updating U-Boot from image... "
    dd if="${UPDATE_IMG_FILE}" of=${BOOT_DISK} bs=512 skip=64 seek=64 count=$((LOADER_END - 64)) conv=fsync,notrunc &>/dev/null
    echo "done"
  elif [ -f ${SYSTEM_ROOT}/usr/share/bootloader/u-boot-rockchip.bin ]; then
    echo -n "Updating U-Boot... "
    dd if=${SYSTEM_ROOT}/usr/share/bootloader/u-boot-rockchip.bin of=${BOOT_DISK} bs=32k seek=1 conv=fsync &>/dev/null
    echo "done"
  fi

# mount ${BOOT_ROOT} r/o
  sync
  mount -o remount,ro ${BOOT_ROOT}

# warn if device tree was not updated
  if [ -n "${non_existent_dtb}" ]; then
    echo "WARNING: The device-tree file ${non_existent_dtb} was not found in the update"
    echo "package and has not been updated. Your device may not boot or work correctly!"
    sleep 10
  fi
