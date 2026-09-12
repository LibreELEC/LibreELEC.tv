# SPDX-License-Identifier: GPL-2.0-only
# Hybrid boot for Variscite DART-MX8MP + DT8MCustomBoard.
# Installed as /boot/boot.scr. BSP bootcmd sources this instead of Image.gz.
#
# No /boot/libreelec/SYSTEM+INITRD  -> Variscite Yocto (current behaviour)
# Payload present                   -> LibreELEC overlay on the same SD partition

echo "VAR-DART-IMX8MP hybrid boot.scr"

setenv le_dir /boot/libreelec
setenv le_dtb imx8mp-var-dart-dt8mcustomboard.dtb

if test -e mmc ${mmcdev}:${mmcpart} ${le_dir}/SYSTEM && test -e mmc ${mmcdev}:${mmcpart} ${le_dir}/INITRD; then
  echo "LibreELEC payload found"

  run ramsize_check
  run prepare_mcore

  if test -e mmc ${mmcdev}:${mmcpart} ${le_dir}/KERNEL; then
    echo "Loading LE KERNEL"
    load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${le_dir}/KERNEL
  else
    echo "Loading vendor ${bootdir}/${image}"
    load mmc ${mmcdev}:${mmcpart} ${img_addr} ${bootdir}/${image}
    unzip ${img_addr} ${loadaddr}
  fi

  load mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${le_dir}/INITRD
  setenv initrd_size ${filesize}

  if test -e mmc ${mmcdev}:${mmcpart} ${le_dir}/${le_dtb}; then
    echo "Loading LE ${le_dtb}"
    load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${le_dir}/${le_dtb}
  elif test -e mmc ${mmcdev}:${mmcpart} ${bootdir}/${le_dtb}; then
    load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${bootdir}/${le_dtb}
  else
    run loadfdt
  fi

  setenv bootargs ${mcore_clk} console=${console} boot=/dev/mmcblk${mmcblk}p${mmcpart} SYSTEM_IMAGE=boot/libreelec/SYSTEM ${cma_size} cma_name=linux,cma systemd.debug_shell=ttymxc0
  echo "bootargs=${bootargs}"
  booti ${loadaddr} ${initrd_addr}:${initrd_size} ${fdt_addr}
else
  echo "No LibreELEC payload, Variscite Yocto"

  run ramsize_check
  run prepare_mcore
  run mmcargs
  run optargs

  if run loadimage; then
    if run loadfdt; then
      booti ${loadaddr} - ${fdt_addr_r}
    else
      echo "findfdt missed, using ${le_dtb}"
      load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${bootdir}/${le_dtb}
      booti ${loadaddr} - ${fdt_addr}
    fi
  else
    echo "Failed to load ${bootdir}/${image}"
  fi
fi
