# SPDX-License-Identifier: GPL-2.0-only
# Native LibreELEC boot for eMMC: FAT /flash (part 1) + ext4 STORAGE (part 2).
# Sourced by Variscite BSP bootcmd as /boot/boot.scr (also copied to /boot.scr).
# Keep boot.cmd as the SD hybrid overlay script.

echo "VAR-DART-IMX8MP LibreELEC eMMC boot.scr"

# Default BSP loadbootscript puts this script at loadaddr. KERNEL is
# also loaded there; relocate once so source survives booti setup.
if test "${le_relocated}" != "1"; then
  setenv le_relocated 1
  echo "Relocating boot.scr to ${scriptaddr}"
  if load mmc ${mmcdev}:${mmcpart} ${scriptaddr} /boot/boot.scr; then
    source ${scriptaddr}
  elif load mmc ${mmcdev}:${mmcpart} ${scriptaddr} boot.scr; then
    source ${scriptaddr}
  else
    echo "WARN: could not relocate boot.scr"
  fi
fi

setenv le_dtb imx8mp-var-dart-dt8mcustomboard.dtb
setenv bootpart 1

run ramsize_check
run prepare_mcore

if test ! -e mmc ${mmcdev}:${bootpart} KERNEL; then
  echo "KERNEL missing on mmc ${mmcdev}:${bootpart}"
  exit
fi

echo "Loading KERNEL"
load mmc ${mmcdev}:${bootpart} ${loadaddr} KERNEL

if test -e mmc ${mmcdev}:${bootpart} INITRD; then
  echo "Loading INITRD"
  load mmc ${mmcdev}:${bootpart} ${initrd_addr} INITRD
  setenv initrd_size ${filesize}
else
  echo "INITRD missing"
  exit
fi

if test -e mmc ${mmcdev}:${bootpart} ${le_dtb}; then
  echo "Loading ${le_dtb}"
  load mmc ${mmcdev}:${bootpart} ${fdt_addr} ${le_dtb}
else
  echo "DTB missing, BSP loadfdt"
  run loadfdt
fi

setenv bootargs ${mcore_clk} console=${console} console=tty0 boot=LABEL=LIBREELEC disk=LABEL=STORAGE ${cma_size} cma_name=linux,cma clk-imx8mp.mcore_booted systemd.debug_shell=ttymxc0
echo "bootargs=${bootargs}"
booti ${loadaddr} ${initrd_addr}:${initrd_size} ${fdt_addr}
