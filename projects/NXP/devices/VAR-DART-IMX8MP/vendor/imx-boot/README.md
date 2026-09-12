# Vendor imx-boot (do not build U-Boot)

UUU and eMMC boot need the **Variscite** `imx-boot` already on this board
(`2024.04-lf_v2024.04_6.6.52-2.2.2_var01`). Mainline U-Boot has no
`imx8mp_var_dart_defconfig` that matches this SOM. The LibreELEC u-boot
package stays a stub.

Place the binary here as `imx-boot` (or `flash.bin`). It is gitignored.

## From the Yocto deploy directory

```
cp tmp/deploy/images/imx8mp-var-dart/imx-boot \
   projects/NXP/devices/VAR-DART-IMX8MP/vendor/imx-boot/imx-boot
```

Use the same scarthgap / `lf_v2024.04` tree that produced the SD card.

## Dump from the running board (SD user area, offset 32 KiB)

```
projects/NXP/devices/VAR-DART-IMX8MP/scripts/dump-imx-boot.sh root@192.168.1.16
```

That is `dd if=/dev/mmcblk1 bs=1k skip=32 count=4096`.

## Dump from eMMC boot0

Only if this board’s recovery image was written to the boot partition:

```
IMX_BOOT_SRC=emmc-boot0 \
  projects/NXP/devices/VAR-DART-IMX8MP/scripts/dump-imx-boot.sh root@192.168.1.16
```

Wrong DRAM/SKU `imx-boot` will fail SDP or hang after `mmc partconf`.
Use a blob from **this** SOM.
