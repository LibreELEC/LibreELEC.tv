# Variscite DART-MX8MP on DT8MCustomBoard

Simplistic multiboot of LibreELEC components
- keep the Variscite scarthgap bootloader, kernel, DTB, and firmware on 
  the SD card. 
- LibreELEC userspace is dropped beside them and selected 
  by `/boot/boot.scr`. eMMC stays the recovery image.

## What is running (SD boot)

- SoM: DART-MX8M-PLUS
- Carrier: DT8MCustomBoard 2.x
- Kernel: 6.6.144-var-lts-next
- U-Boot: 2024.04-lf_v2024.04_6.6.52-2.2.2_var01 at SD offset 32 KiB
- Root: `/dev/mmcblk1p1` (single ext4, label `root`)
- Recovery: eMMC `/dev/mmcblk2p1` (do not flash boot0)

U-Boot `bootcmd` is BSP (`run bsp_bootcmd`). If `/boot/boot.scr` exists it is
sourced and Image.gz is not loaded. That is the overlay hook.

The install script also moves `loadbootscript` from `loadaddr` to
`scriptaddr` (0x43500000). Otherwise `source` runs from the same address
used to unzip `Image.gz`, and the rest of the script is destroyed.

## Build SYSTEM + LE kernel

`kodi/appliance.xml` is merged into SYSTEM by `scripts/pre-squash.sh`. A
plain `make system` does **not** rebuild the kodi package when that file
changes (the install stamp ignores `devices/$DEVICE/kodi`). The hook
patches `image/system` after packages and before squashfs.

From `LibreELEC.tv` (not a full disk image — do not use `make image` yet):

```
PROJECT=NXP DEVICE=VAR-DART-IMX8MP ARCH=aarch64 UBOOT_SYSTEM=imx8mp-var-dart make system
```

`LINUX=variscite` builds `https://github.com/varigit/linux-imx` at
`2365567b4cff` (6.6.144), galcore off / etnaviv on, `uname` suffix `-le`.
Vendor `Image.gz` and U-Boot stay in place. Pack INITRD once with
`scripts/pack-initrd.sh` if `target/*.initrd` is missing.

## Overlay layout on the SD card

```
/boot/boot.scr                         # hybrid script
/boot/Image.gz                         # Yocto/Variscite kernel (unchanged)
/boot/imx8mp-var-dart-dt8mcustomboard.dtb
/boot/libreelec/SYSTEM                 # LE squashfs
/boot/libreelec/INITRD                 # LE initramfs (hook)
/boot/libreelec/KERNEL                 # LE-built variscite linux-imx
/boot/libreelec/imx8mp-var-dart-dt8mcustomboard.dtb  # LE DTB (LVDS off)
```

Two kernels on purpose: Yocto keeps `Image.gz`. LibreELEC uses
`linux-imx` `6.6-2.2.x-imx_var01` @ `2365567b4cff` (`LINUX=variscite`),
galcore off / etnaviv on, `uname` suffix `-le`. The LE DTB retargets
`gpu_3d`/`gpu_2d` to `vivante,gc` (etnaviv), disables unused LVDS, and
applies the SOM 1.x WiFi/BT SKU (BCM4339, not IW612). `boot.scr` loads
LE KERNEL when that file exists. SYSTEM must include `firmware-imx`
(`imx/xcvr/xcvr-imx8mp.bin`, VPU).

*** HW support is ATM minor, expect no Bluetooth/WiFI/etc..., adding later.

## Install from the build host

`make system` writes the full overlay set under `target/` with the same prefix:

```
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.kernel
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.system
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.initrd
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.dtb
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.boot.scr
target/LibreELEC-VAR-DART-IMX8MP.aarch64-…-imx8mp-var-dart.overlay
```

The `.overlay` file is the upload map. Do not skip `.dtb` or `.boot.scr`.
Do not overwrite `/boot/Image.gz`.

Boot DT8MCustomBoard with DART-iMX8MP in SD-card boot-mode using Yocto image provided by Variscite.
DHCP will give you some IP, in our case was 192.168.1.100, run the install SD script:
(After patching SD card with script, Yocto will be a secondary OS )

```
projects/NXP/devices/VAR-DART-IMX8MP/scripts/install-sd-overlay.sh root@192.168.1.100
```

That copies KERNEL, SYSTEM, INITRD, DTB, and `boot.scr`, then fixes
`loadbootscript` to `scriptaddr`. Then reboot. If SD fails to boot, remove
the card (or dip-switch to eMMC).

Raw SD access on the PC is only needed later, if we repartition into a FAT
`/flash` + ext4 STORAGE layout. It is not needed for this overlay.

## Troubleshooting

As this is the first version with LibreELEC initrd/system, one might run into boot/system troubles.
With such situations, we could boot back into primary Yocto system.
One way of doing it, stop in booloader mode:
```
run ramsize_check; run prepare_mcore; run mmcargs; run loadimage; run loadfdt
booti ${loadaddr} - ${fdt_addr_r}
```

