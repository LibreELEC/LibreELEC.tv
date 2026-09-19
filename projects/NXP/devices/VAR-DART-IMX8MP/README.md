# Variscite DART-MX8MP on DT8MCustomBoard

Two install paths share the same kernel (`LINUX=variscite`).

- **SD overlay** (`make system`): Yocto `/boot` stays; LibreELEC is
  `/boot/libreelec` + `boot.scr`. Do **not** flash eMMC boot0 from this
  path. It is the recovery image.
- **eMMC UUU** (`make image`): FAT `LIBREELEC` + ext4 `STORAGE`. UUU
  writes the **source-built** `flash.bin` to eMMC boot0 and replaces the
  Yocto user-area image.

## Hardware

- SoM: DART-MX8M-PLUS, PN **VSM-DT8MP-302**, rev **1.3**, **4 GiB** DRAM
- Carrier: DT8MCustomBoard **2.x** (U-Boot control DTB `model` still
  says 3.x; carrier EEPROM is `dt8m` / legacy)
- Console: UART1 / `ttymxc0` @ 115200
- GPU: etnaviv + imx-drm (no galcore). Display HDMI-A-1

## Bootloader (`flash.bin`)

Assembled by [varigit imx-mkimage](https://github.com/varigit/imx-mkimage/tree/lf-6.18.20_2.0.0_var01/iMX8M)
`iMX8M/` (`SOC=iMX8MP flash_evk`). That is **not** `iMX8QX` (SCU/AHAB)
and **not** U-Boot’s in-tree `imx8mimage`. There is no `make u-boot`
target; `make image` builds it, or:

```
PROJECT=NXP DEVICE=VAR-DART-IMX8MP ARCH=aarch64 UBOOT_SYSTEM=imx8mp-var-dart \
  ./scripts/build u-boot
```

| Piece | Tree | Notes |
|---|---|---|
| U-Boot | `sigysmund/uboot-imx` @ `177ee806` | `imx8mp_var_dart_defconfig`, lf_v2025.04 |
| ATF | Trusted Firmware-A **2.15.0** | `PLAT=imx8mp`, `SPD=opteed`, UART1 `0x30860000` |
| OP-TEE | `nxp-imx/imx-optee-os` `lf-6.18.20_2.0.0` | `imx-mx8mpevk`, 4 GiB, UART1. FIT gets **`tee-raw.bin`** (headered `tee.bin` hangs ATF at `Initializing BL32`) |
| LPDDR4 | NXP `firmware-imx` `_202006` | Training only. HDMI/XCVR/VPU/codec stay on SYSTEM |

Output: `build.*/build/u-boot-*/flash.bin`. `pack-uuu-bundle.sh` prefers
that file. A blob in `vendor/imx-boot/` is emergency fallback only.

Device patches (`patches/u-boot/`):

- `0001-…romapi…`: USB HID pages are 1024 B; the ATF+TEE FIT FDT is 1120 B.
  Search in 4 KiB, then download the **exact** remainder (do not
  page-align past EOF or UUU hits 100% while the ROM waits).
- `0002-…fixdt…`: missing Sonata `gpio@22` is success. The 3.x control
  DTB never has that node; treating `FDT_ERR_NOTFOUND` as fatal hung
  after `DRAM:`.

SPL uses ROMAPI USB (`CONFIG_SPL_BOOTROM_SUPPORT`, no gadget). UUU
must keep **SDPS** open (`SDPS[-t 10000]: boot -f imx-boot`). SDP/SDPV
run only if SPL re-enumerates; this SPL does not.

Confirmed on this board: USB SDP → ATF → OP-TEE → U-Boot **2025.04** →
Fastboot → `FB: flash bootloader` to **mmc2 boot0**.

Env is at raw **`0x700000`**, size `0x4000`. FAT starts at LBA **32768**
(`SYSTEM_PART_START=32768`) so that hole is not inside the partition.
`CONFIG_SYS_MMC_ENV_DEV=1` is **SD**. Do **not** `saveenv` over SDP (no
SD card). The pack script writes `uboot.env` into `image.img` at
`0x700000`. `bootcmd=run bsp_bootcmd`. `loadbootscript` must load to
`scriptaddr` (`0x43500000`) or `source` destroys the script when KERNEL
lands at `loadaddr`.

NXP runtime firmware (HDMI/XCVR/VPU/codec) is on SYSTEM via
`firmware-imx`. It is not a substitute for building U-Boot.

## Build SYSTEM + LE kernel

`kodi/appliance.xml` is merged into SYSTEM by `scripts/pre-squash.sh`.
A plain `make system` does **not** rebuild the kodi package when that
file changes (the install stamp ignores `devices/$DEVICE/kodi`). The
hook patches `image/system` after packages and before squashfs.

```
PROJECT=NXP DEVICE=VAR-DART-IMX8MP ARCH=aarch64 UBOOT_SYSTEM=imx8mp-var-dart make system
```

`LINUX=variscite` builds `https://github.com/varigit/linux-imx` at
`2365567b4cff` (6.6.144), galcore off / etnaviv on, `uname` suffix `-le`.
On the SD overlay, vendor `Image.gz` and the Yocto U-Boot stay in place.
Pack INITRD once with `scripts/pack-initrd.sh` if `target/*.initrd` is
missing.

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

Two kernels on purpose. Yocto keeps `Image.gz`. LibreELEC uses
`linux-imx` `6.6-2.2.x-imx_var01` @ `2365567b4cff`. The LE DTB retargets
`gpu_3d`/`gpu_2d` to `vivante,gc` (etnaviv), disables unused LVDS, and
applies the SOM 1.x WiFi/BT SKU (BCM4339, not IW612). `boot.scr` loads
LE KERNEL when that file exists. SYSTEM must include `firmware-imx`
(`imx/xcvr/xcvr-imx8mp.bin`, VPU).

U-Boot `bootcmd` is BSP (`run bsp_bootcmd`). If `/boot/boot.scr` exists
it is sourced and `Image.gz` is not loaded. That is the overlay hook.

The Yocto SD U-Boot is still
`2024.04-lf_v2024.04_6.6.52-2.2.2_var01` at SD offset 32 KiB. Root is
`/dev/mmcblk1p1` (ext4, label `root`).

HW support is still thin (no Bluetooth/WiFi yet).

## Install from the build host — SD overlay

`make system` writes the overlay set under `target/`:

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

Boot the board in **SD** mode with the Variscite Yocto image. After
DHCP (example `192.168.1.100`):

```
projects/NXP/devices/VAR-DART-IMX8MP/scripts/install-sd-overlay.sh root@192.168.1.100
```

That copies KERNEL, SYSTEM, INITRD, DTB, and `boot.scr`, then fixes
`loadbootscript` to `scriptaddr`. Then reboot. If SD fails, remove the
card or dip-switch to eMMC. After the overlay, Yocto is the secondary OS
(see Troubleshooting).

## eMMC UUU image (native LibreELEC)

FAT `/flash` (label `LIBREELEC`) + ext4 `STORAGE`. This **replaces** the
Yocto eMMC user area. Keep the SD overlay as recovery.

```
PROJECT=NXP DEVICE=VAR-DART-IMX8MP ARCH=aarch64 UBOOT_SYSTEM=imx8mp-var-dart make image
projects/NXP/devices/VAR-DART-IMX8MP/scripts/pack-uuu-bundle.sh
```

Board: dip-switch to **SD boot**, **no SD card**, USB OTG, power on.

```
cd target/uuu-emmc
sudo uuu uuu-boot.auto    # boot0 only; leaves FAT/STORAGE alone
```

Success: serial shows U-Boot **2025.04**, `DRAM: 4 GiB`, Fastboot, then
UUU `FB: flash bootloader` / `Success 1`. Fastboot may probe MMC 1 (SD,
empty) then write **MMC 2**. `extcon_ptn5150` / `ep1in-bulk` warnings are
noise if the write finishes.

Then dip-switch to **eMMC** and reboot. That only proves ROM + our
`flash.bin`. User area is still whatever was there.

When eMMC U-Boot looks good, same USB setup:

```
cd target/uuu-emmc && sudo uuu uuu.auto
```

Then dip-switch to eMMC again. `boot-emmc.cmd` relocates itself to
`scriptaddr` so a default env still works.

If a previous run failed only on `saveenv`:

```
cd target/uuu-emmc && sudo uuu uuu-env.auto
```

Or from an eMMC U-Boot prompt (`saveenv` works once the ROM booted eMMC):

```
setenv loadbootscript 'load mmc ${mmcdev}:${mmcpart} ${scriptaddr} ${bootdir}/${bsp_script}'
setenv bootscript 'echo Running bootscript from mmc ...; source ${scriptaddr}'
setenv bootcmd 'run bsp_bootcmd'
saveenv
```

If env loaded but autoboot ran `boota mmc2`, `bootcmd` was missing from
the env blob and Fastboot filled in the Android default. Set `bootcmd`
as above (or `run bsp_bootcmd` to test without saving).

`scripts/verify-le-image.sh` checks labels, `/flash` files, and the env
hole.

## Troubleshooting

To get back to the Yocto kernel on the SD overlay, stop in U-Boot:

```
run ramsize_check; run prepare_mcore; run mmcargs; run loadimage; run loadfdt
booti ${loadaddr} - ${fdt_addr_r}
```

For example this is the serial log of the flashed bootloader and system images:
```
U-Boot SPL 2025.04 (Sep 13 2026 - 21:43:15 +0200)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x0, pagesize 0x200, ivt offset 0x0
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.15.0(release):12.0.0-9481-g56e552fc61-dirty
NOTICE:  BL31: Built : 20:56:04, Sep 13 2026
INFO:    GICv3 with legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 191
INFO:    BL31: Initializing runtime services
INFO:    BL31: Initializing BL32
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x40200000
INFO:    SPSR = 0x3c9


U-Boot 2025.04 (Sep 13 2026 - 21:43:15 +0200)

CPU:   i.MX8MP[8] rev1.1 1800 MHz (running at 1200 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 55C
Reset cause: POR
Model: Variscite DART-MX8M-PLUS on DT8MCustomBoard 3.x
DRAM:  4 GiB
extcon_ptn5150_parse_fdt: failed to find i2c-bus, err=-1
extcon_ptn5150_setup: Failed to parse device tree
Core:  145 devices, 30 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(2)... OK
In:    serial
Out:   serial
Err:   serial
SEC0:  RNG instantiated
switch to partitions #0, OK
mmc2(part 0) is current device

Part number: VSM-DT8MP-302
Assembly: AS411223998
Production date: 2025 Jan 09
Serial Number: f8:dc:7a:f5:c8:b6
SOM revision: 1.3
flash target is MMC:2
Net:   Could not get PHY for FEC1: addr 1
eth0: ethernet@30bf0000
Fastboot: Normal
Normal Boot
Hit any key to stop autoboot:  0 
Running BSP bootcmd ...
switch to partitions #0, OK
mmc2(part 0) is current device
1823 bytes read in 1 ms (1.7 MiB/s)
Running bootscript from mmc ...
## Executing script at 43500000
VAR-DART-IMX8MP LibreELEC eMMC boot.scr
Relocating boot.scr to 0x43500000
1823 bytes read in 1 ms (1.7 MiB/s)
## Executing script at 43500000
VAR-DART-IMX8MP LibreELEC eMMC boot.scr
Loading KERNEL
35396096 bytes read in 107 ms (315.5 MiB/s)
Loading INITRD
2441527 bytes read in 8 ms (291.1 MiB/s)
Loading imx8mp-var-dart-dt8mcustomboard.dtb
83509 bytes read in 1 ms (79.6 MiB/s)
bootargs=clk-imx8mp.mcore_booted console=ttymxc0,115200 console=tty0 boot=LABEL=LIBREELEC disk=LABEL=STORAGE cma=704M cma_name=linux,cma clk-imx8mp.mcore_booted systemd.debug_shell=ttymxc0
Moving Image from 0x40480000 to 0x40600000, end=0x42870000
## Flattened Device Tree blob at 43000000
   Booting using the fdt blob at 0x43000000
Working FDT set to 43000000
   Using Device Tree in place at 0000000043000000, end 0000000043017634
Working FDT set to 43000000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.6.144-le (ziga@liam) (aarch64-libreelec-linux-gnu-gcc-16.2.0 (GCC) 16.2.0, GNU ld (GNU Binutils) 2.47.20260726) #1 SMP PREEMPT Sat Sep 12 21:58:27 CEST 2026
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Variscite DART-MX8M-PLUS on DT8MCustomBoard 2.x
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000000900000..0x000000000096ffff (448 KiB) nomap non-reusable ocram@900000
[    0.000000] OF: reserved mem: 0x0000000056000000..0x0000000057dfffff (30720 KiB) nomap non-reusable optee_core@56000000
[    0.000000] OF: reserved mem: 0x0000000057e00000..0x0000000057ffffff (2048 KiB) nomap non-reusable optee_shm@57e00000
[    0.000000] OF: reserved mem: 0x0000000060000000..0x000000006fffffff (262144 KiB) nomap non-reusable gpu_reserved@100000000
[    0.000000] OF: reserved mem: 0x0000000092400000..0x00000000933fffff (16384 KiB) nomap non-reusable dsp@92400000
[    0.000000] OF: reserved mem: 0x0000000093400000..0x00000000942effff (15296 KiB) nomap non-reusable dsp_reserved_heap@93400000
[    0.000000] OF: reserved mem: 0x00000000942f0000..0x00000000942f7fff (32 KiB) nomap non-reusable vdev0vring0@942f0000
[    0.000000] OF: reserved mem: 0x00000000942f8000..0x00000000942fffff (32 KiB) nomap non-reusable vdev0vring1@942f8000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000094300000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node vdev0buffer@94300000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000094300000..0x00000000943fffff (1024 KiB) nomap non-reusable vdev0buffer@94300000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x13f83a6c0-0x13f83cfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000055ffffff]
[    0.000000]   node   0: [mem 0x0000000058000000-0x000000005fffffff]
[    0.000000]   node   0: [mem 0x0000000060000000-0x000000006fffffff]
[    0.000000]   node   0: [mem 0x0000000070000000-0x00000000923fffff]
[    0.000000]   node   0: [mem 0x0000000092400000-0x00000000943fffff]
[    0.000000]   node   0: [mem 0x0000000094400000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] On node 0, zone DMA: 8192 pages in unavailable ranges
[    0.000000] cma: Reserved 704 MiB at 0x00000000d4000000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.5
[    0.000000] percpu: Embedded 22 pages/cpu s50536 r8192 d31384 u90112
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: clk-imx8mp.mcore_booted console=ttymxc0,115200 console=tty0 boot=LABEL=LIBREELEC disk=LABEL=STORAGE cma=704M cma_name=linux,cma clk-imx8mp.mcore_booted systemd.debug_shell=ttymxc0
[    0.000000] Unknown kernel command line parameters "boot=LABEL=LIBREELEC disk=LABEL=STORAGE", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1024000
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000d0000000-0x00000000d4000000] (64MB)
[    0.000000] Memory: 2961700K/4161536K available (20608K kernel code, 1606K rwdata, 7816K rodata, 4352K init, 666K bss, 478940K reserved, 720896K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 160 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000038880000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 8.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns
[    0.000000] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2199023255500ns
[    0.000524] Console: colour dummy device 80x25
[    0.000533] printk: console [tty0] enabled
[    0.001265] Calibrating delay loop (skipped), value calculated using timer frequency.. 16.00 BogoMIPS (lpj=32000)
[    0.001289] pid_max: default: 32768 minimum: 301
[    0.001362] LSM: initializing lsm=capability,integrity
[    0.001456] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.001482] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.002953] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.003052] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.003233] rcu: Hierarchical SRCU implementation.
[    0.003248] rcu:     Max phase no-delay instances is 1000.
[    0.004890] EFI services will not be available.
[    0.005120] smp: Bringing up secondary CPUs ...
[    0.005577] Detected VIPT I-cache on CPU1
[    0.005637] GICv3: CPU1: found redistributor 1 region 0:0x00000000388a0000
[    0.005671] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.006173] Detected VIPT I-cache on CPU2
[    0.006215] GICv3: CPU2: found redistributor 2 region 0:0x00000000388c0000
[    0.006235] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.006696] Detected VIPT I-cache on CPU3
[    0.006737] GICv3: CPU3: found redistributor 3 region 0:0x00000000388e0000
[    0.006755] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.006822] smp: Brought up 1 node, 4 CPUs
[    0.006907] SMP: Total of 4 processors activated.
[    0.006919] CPU features: detected: 32-bit EL0 Support
[    0.006929] CPU features: detected: 32-bit EL1 Support
[    0.006941] CPU features: detected: CRC32 instructions
[    0.007007] CPU: All CPU(s) started at EL2
[    0.007033] alternatives: applying system-wide alternatives
[    0.009050] devtmpfs: initialized
[    0.019704] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.019747] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.038990] pinctrl core: initialized pinctrl subsystem
[    0.042047] DMI not present or invalid.
[    0.042650] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.043506] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.043656] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.043854] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.043908] audit: initializing netlink subsys (disabled)
[    0.044061] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    0.044581] thermal_sys: Registered thermal governor 'step_wise'
[    0.044586] thermal_sys: Registered thermal governor 'power_allocator'
[    0.044628] cpuidle: using governor menu
[    0.044859] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.044951] ASID allocator initialised with 65536 entries
[    0.046229] Serial: AMBA PL011 UART driver
[    0.046336] imx mu driver is registered.
[    0.046365] imx rpmsg driver is registered.
[    0.055120] /soc@0: Fixed dependency cycle(s) with /soc@0/bus@30000000/efuse@30350000/unique-id@8
[    0.055764] /soc@0/bus@30800000/i2c@30a30000/typec@3d: Fixed dependency cycle(s) with /soc@0/usb@32f10100/usb@38100000
[    0.055848] /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e40000
[    0.056005] /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e50000
[    0.056442] /soc@0/bus@32c00000/camera/csi@32e40000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c
[    0.056525] /soc@0/bus@32c00000/camera/csi@32e50000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c
[    0.056850] /soc@0/bus@30c00000/lcd-controller@32fc6000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/hdmi@32fd8000
[    0.057009] /soc@0/bus@30c00000/hdmi@32fd8000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/lcd-controller@32fc6000
[    0.057188] /soc@0/interrupt-controller@38800000: Fixed dependency cycle(s) with /soc@0/interrupt-controller@38800000
[    0.057338] /soc@0/usb@32f10100/usb@38100000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/typec@3d
[    0.059688] /soc@0/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s) with /soc@0/bus@30000000/pinctrl@30330000/hoggrp
[    0.060147] imx8mp-pinctrl 30330000.pinctrl: initialized IMX pinctrl driver
[    0.060699] /soc@0/bus@30000000/efuse@30350000: Fixed dependency cycle(s) with /soc@0/bus@30000000/clock-controller@30380000
[    0.061828] /soc@0/bus@30000000/efuse@30350000: Fixed dependency cycle(s) with /soc@0/bus@30000000/clock-controller@30380000
[    0.064771] /soc@0/bus@30800000/i2c@30a30000/typec@3d: Fixed dependency cycle(s) with /soc@0/usb@32f10100/usb@38100000
[    0.064849] /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e40000
[    0.064964] /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e50000
[    0.068116] /soc@0/bus@30800000/i2c@30a30000/typec@3d: Fixed dependency cycle(s) with /soc@0/usb@32f10100/usb@38100000
[    0.068236] /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e40000
[    0.068904] /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e50000
[    0.071746] /soc@0/bus@32c00000/camera/csi@32e40000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c
[    0.071840] /soc@0/bus@32c00000/camera/csi@32e50000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c
[    0.073514] /soc@0/bus@32c00000/camera/csi@32e40000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c
[    0.073602] /soc@0/bus@32c00000/camera/csi@32e50000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c
[    0.074335] /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e40000
[    0.074458] /soc@0/bus@32c00000/camera/csi@32e40000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/ov5640_mipi@3c
[    0.074788] /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c: Fixed dependency cycle(s) with /soc@0/bus@32c00000/camera/csi@32e50000
[    0.074897] /soc@0/bus@32c00000/camera/csi@32e50000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a50000/ov5640_mipi@3c
[    0.075552] /soc@0/bus@30c00000/lcd-controller@32fc6000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/hdmi@32fd8000
[    0.075675] /soc@0/bus@30c00000/hdmi@32fd8000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/lcd-controller@32fc6000
[    0.078285] /soc@0/bus@30c00000/lcd-controller@32fc6000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/hdmi@32fd8000
[    0.078692] /soc@0/bus@30c00000/lcd-controller@32fc6000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/hdmi@32fd8000
[    0.078818] /soc@0/bus@30c00000/hdmi@32fd8000: Fixed dependency cycle(s) with /soc@0/bus@30c00000/lcd-controller@32fc6000
[    0.080933] /soc@0/usb@32f10100/usb@38100000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/typec@3d
[    0.085158] Modules: 23952 pages in range for non-PLT usage
[    0.085167] Modules: 515472 pages in range for PLT usage
[    0.085907] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.085937] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.085949] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.085961] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.085974] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.085985] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.085997] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.086010] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.088140] ACPI: Interpreter disabled.
[    0.089472] iommu: Default domain type: Translated
[    0.089493] iommu: DMA domain TLB invalidation policy: strict mode
[    0.089806] SCSI subsystem initialized
[    0.090140] usbcore: registered new interface driver usbfs
[    0.090188] usbcore: registered new interface driver hub
[    0.090225] usbcore: registered new device driver usb
[    0.091600] mc: Linux media interface: v0.10
[    0.091647] videodev: Linux video capture interface: v2.00
[    0.091732] pps_core: LinuxPPS API ver. 1 registered
[    0.091743] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.091768] PTP clock support registered
[    0.091970] EDAC MC: Ver: 3.0.0
[    0.092445] scmi_core: SCMI protocol bus registered
[    0.092804] FPGA manager framework
[    0.092887] Advanced Linux Sound Architecture Driver Initialized.
[    0.093602] Bluetooth: Core ver 2.22
[    0.093634] NET: Registered PF_BLUETOOTH protocol family
[    0.093645] Bluetooth: HCI device and connection manager initialized
[    0.093663] Bluetooth: HCI socket layer initialized
[    0.093676] Bluetooth: L2CAP socket layer initialized
[    0.093696] Bluetooth: SCO socket layer initialized
[    0.094026] vgaarb: loaded
[    0.094597] clocksource: Switched to clocksource arch_sys_counter
[    0.094812] VFS: Disk quotas dquot_6.6.0
[    0.094853] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.095133] pnp: PnP ACPI: disabled
[    0.101997] NET: Registered PF_INET protocol family
[    0.102182] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.105256] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.105341] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.105367] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.105587] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.106441] TCP: Hash tables configured (established 32768 bind 32768)
[    0.106557] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.106706] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.106908] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.106950] PCI: CLS 0 bytes, default 64
[    0.110824] kvm [1]: IPA Size Limit: 40 bits
[    0.112621] kvm [1]: GICv3: no GICV resource entry
[    0.112638] kvm [1]: disabling GICv2 emulation
[    0.112662] kvm [1]: GIC system register CPU interface enabled
[    0.112694] kvm [1]: vgic interrupt IRQ9
[    0.112721] kvm [1]: Hyp mode initialized successfully
[    0.113899] Initialise system trusted keyrings
[    0.114094] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.114367] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.114408] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.114646] 9p: Installing v9fs 9p2000 file system support
[    0.149140] Key type asymmetric registered
[    0.149171] Asymmetric key parser 'x509' registered
[    0.149247] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.149430] io scheduler mq-deadline registered
[    0.149444] io scheduler kyber registered
[    0.149482] io scheduler bfq registered
[    0.158027] EINJ: ACPI disabled.
[    0.159473] M4 is started
[    0.169279] mxs-dma 33000000.dma-apbh: initialized
[    0.171192] SoC: i.MX8MP revision 1.1
[    0.171715] Bus freq driver module loaded
[    0.191652] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.194989] 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 15, base_baud = 1500000) is a IMX
[    0.195055] printk: console [ttymxc0] enabled
[    0.204600] Unpacking initramfs...
[    0.218627] 30880000.serial: ttymxc2 at MMIO 0x30880000 (irq = 16, base_baud = 1500000) is a IMX
[    0.324017] Freeing initrd memory: 2384K
[    0.326623] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 17, base_baud = 1500000) is a IMX
[    1.783970] 30a60000.serial: ttymxc3 at MMIO 0x30a60000 (irq = 18, base_baud = 5000000) is a IMX
[    1.793000] serial serial0: tty port ttymxc3 registered
[    1.811862] etnaviv etnaviv: bound 38000000.gpu3d (ops gpu_ops)
[    1.817954] etnaviv etnaviv: bound 38008000.gpu2d (ops gpu_ops)
[    1.823990] etnaviv-gpu 38000000.gpu3d: model: GC7000, revision: 6204
[    1.830570] etnaviv-gpu 38008000.gpu2d: model: GC520, revision: 5341
[    1.837324] [drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0
[    1.851055] loop: module loaded
[    1.856011] megasas: 07.725.01.00-rc1
[    1.867958] tun: Universal TUN/TAP device driver, 1.6
[    1.874149] thunder_xcv, ver 1.0
[    1.877444] thunder_bgx, ver 1.0
[    1.880728] nicpf, ver 1.0
[    1.886432] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    1.893682] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.899063] hclge is initializing
[    1.902414] e1000: Intel(R) PRO/1000 Network Driver
[    1.907306] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.913111] e1000e: Intel(R) PRO/1000 Network Driver
[    1.918091] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.924073] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.929486] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.935111] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    1.941395] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.947547] sky2: driver version 1.30
[    1.951982] usbcore: registered new device driver r8152-cfgselector
[    1.958312] usbcore: registered new interface driver r8152
[    1.964282] VFIO - User Level meta-driver version: 0.3
[    1.971219] /soc@0/bus@30800000/i2c@30a30000/typec@3d: Fixed dependency cycle(s) with /soc@0/usb@32f10100/usb@38100000
[    1.982037] /soc@0/usb@32f10100/usb@38100000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/typec@3d
[    1.998014] usbcore: registered new interface driver uas
[    2.003409] usbcore: registered new interface driver usb-storage
[    2.009510] usbcore: registered new interface driver usbserial_generic
[    2.016074] usbserial: USB Serial support registered for generic
[    2.022129] usbcore: registered new interface driver ftdi_sio
[    2.027913] usbserial: USB Serial support registered for FTDI USB Serial Device
[    2.035268] usbcore: registered new interface driver usb_serial_simple
[    2.041834] usbserial: USB Serial support registered for carelink
[    2.047961] usbserial: USB Serial support registered for flashloader
[    2.054351] usbserial: USB Serial support registered for funsoft
[    2.060391] usbserial: USB Serial support registered for google
[    2.066346] usbserial: USB Serial support registered for hp4x
[    2.072127] usbserial: USB Serial support registered for kaufmann
[    2.078254] usbserial: USB Serial support registered for libtransistor
[    2.084875] usbserial: USB Serial support registered for moto_modem
[    2.091223] usbserial: USB Serial support registered for motorola_tetra
[    2.097886] usbserial: USB Serial support registered for nokia
[    2.103752] usbserial: USB Serial support registered for novatel_gps
[    2.110146] usbserial: USB Serial support registered for owon
[    2.115934] usbserial: USB Serial support registered for siemens_mpi
[    2.122326] usbserial: USB Serial support registered for suunto
[    2.128282] usbserial: USB Serial support registered for vivopay
[    2.134322] usbserial: USB Serial support registered for zio
[    2.140038] usbcore: registered new interface driver usb_ehset_test
[    2.150067] input: 30370000.snvs:snvs-powerkey as /devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-powerkey/input/input0
[    2.164575] i2c_dev: i2c /dev entries driver
[    2.175958] Bluetooth: HCI UART driver ver 2.3
[    2.180440] Bluetooth: HCI UART protocol H4 registered
[    2.185595] Bluetooth: HCI UART protocol BCSP registered
[    2.190968] Bluetooth: HCI UART protocol LL registered
[    2.196123] Bluetooth: HCI UART protocol ATH3K registered
[    2.201555] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    2.207975] Bluetooth: HCI UART protocol Broadcom registered
[    2.213678] Bluetooth: HCI UART protocol QCA registered
[    2.219144] EDAC MC: ECC not enabled
[    2.224443] sdhci: Secure Digital Host Controller Interface driver
[    2.230658] sdhci: Copyright(c) Pierre Ossman
[    2.235755] Synopsys Designware Multimedia Card Interface Driver
[    2.242741] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.252690] ledtrig-cpu: registered to indicate activity on CPUs
[    2.260351] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    2.267522] usbcore: registered new interface driver usbhid
[    2.273123] usbhid: USB HID core driver
[    2.278058] mxc-mipi-csi2-sam 32e40000.csi: supply mipi-phy not found, using dummy regulator
[    2.278626] mmc2: SDHCI controller on 30b60000.mmc [30b60000.mmc] using ADMA
[    2.282334] mmc0: SDHCI controller on 30b40000.mmc [30b40000.mmc] using ADMA
[    2.286992] : mipi_csis_imx8mp_phy_reset, No remote pad found!
[    2.306558] mxc-mipi-csi2-sam 32e40000.csi: lanes: 2, hs_settle: 6, clk_settle: 2, wclk: 1, freq: 500000000
[    2.316624] mxc-mipi-csi2-sam 32e50000.csi: supply mipi-phy not found, using dummy regulator
[    2.325453] : mipi_csis_imx8mp_phy_reset, No remote pad found!
[    2.331349] mxc-mipi-csi2-sam 32e50000.csi: lanes: 2, hs_settle: 6, clk_settle: 2, wclk: 1, freq: 266000000
[    2.343897] mxc-isi_v1 32e00000.isi: mxc_isi.0 registered successfully
[    2.351637] mxc-isi_v1 32e02000.isi: mxc_isi.1 registered successfully
[    2.361830] mmc2: new HS400 Enhanced strobe MMC card at address 0001
[    2.368667] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    2.369375] mmcblk2: mmc2:0001 AJTD4R 14.6 GiB
[    2.384272]  mmcblk2: p1 p2
[    2.385063]  cs_system_cfg: CoreSight Configuration manager initialised
[    2.387677] mmcblk2boot0: mmc2:0001 AJTD4R 4.00 MiB
[    2.395472] /soc@0: Fixed dependency cycle(s) with /soc@0/bus@30000000/efuse@30350000
[    2.399732] mmcblk2boot1: mmc2:0001 AJTD4R 4.00 MiB
[    2.408566] optee: probing for conduit method.
[    2.412332] mmcblk2rpmb: mmc2:0001 AJTD4R 4.00 MiB, chardev (234:0)
[    2.415973] optee: revision 4.10 (56e552fc61863738)
[    2.422479] optee: dynamic shared memory is enabled
[    2.432709] optee: initialized driver
[    2.438466] hantrodec 0 : module inserted. Major = 509
[    2.444207] hantrodec 1 : module inserted. Major = 509
[    2.450736] hantroenc: HW at base <0000000038320000> with ID <0x80006200>
[    2.457684] hx280enc: module inserted. Major <508>
[    2.467257] NET: Registered PF_LLC protocol family
[    2.472241] u32 classifier
[    2.475062]     input device check on
[    2.478750]     Actions configured
[    2.483373] NET: Registered PF_INET6 protocol family
[    2.489954] Segment Routing with IPv6
[    2.493680] In-situ OAM (IOAM) with IPv6
[    2.497682] NET: Registered PF_PACKET protocol family
[    2.499586] mmc0: Failed to initialize a non-removable card
[    2.502771] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    2.522324] Bluetooth: RFCOMM TTY layer initialized
[    2.527229] Bluetooth: RFCOMM socket layer initialized
[    2.532399] Bluetooth: RFCOMM ver 1.11
[    2.536175] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.541501] Bluetooth: BNEP filters: protocol multicast
[    2.546744] Bluetooth: BNEP socket layer initialized
[    2.551723] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.557660] Bluetooth: HIDP socket layer initialized
[    2.563637] 8021q: 802.1Q VLAN Support v1.8
[    2.567859] lib80211: common routines for IEEE802.11 drivers
[    2.573587] 9pnet: Installing 9P2000 support
[    2.578765] NET: Registered PF_VSOCK protocol family
[    2.599888] registered taskstats version 1
[    2.604163] Loading compiled-in X.509 certificates
[    2.632613] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.643227] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.653776] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.664323] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.674903] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.687063] gpio-142 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
[    2.696667] i2c i2c-0: using pinctrl states for GPIO recovery
[    2.703154] i2c i2c-0: IMX I2C adapter registered
[    2.708649] gpio-144 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
[    2.713050] nxp-pca9450 0-0025: pca9450bc probed.
[    2.717967] i2c i2c-1: using pinctrl states for GPIO recovery
[    2.728247] /soc@0/usb@32f10100/usb@38100000: Fixed dependency cycle(s) with /soc@0/bus@30800000/i2c@30a30000/typec@3d
[    2.739093] /soc@0/bus@30800000/i2c@30a30000/typec@3d: Fixed dependency cycle(s) with /soc@0/usb@32f10100/usb@38100000
[    2.750936] i2c i2c-1: IMX I2C adapter registered
[    2.756468] gpio-146 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
[    2.765752] i2c i2c-2: using pinctrl states for GPIO recovery
[    2.771566] i2c i2c-2: IMX I2C adapter registered
[    2.776834] gpio-148 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
[    2.786404] i2c i2c-3: using pinctrl states for GPIO recovery
[    2.793004] pca953x 3-0020: using no AI
[    2.799960] pca953x 3-0020: Extended registers supported
[    2.805686] pca953x 3-0021: using no AI
[    2.810744] pca953x 3-0021: Extended registers supported
[    2.816174] i2c i2c-3: IMX I2C adapter registered
[    2.821833] imx8mq-usb-phy 381f0040.usb-phy: supply vbus not found, using dummy regulator
[    2.830484] imx8mq-usb-phy 382f0040.usb-phy: supply vbus not found, using dummy regulator
[    2.846509] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
[    2.853834] imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
[    2.855347] dwhdmi-imx 32fd8000.hdmi: Detected HDMI TX controller v2.13a with HDCP (samsung_dw_hdmi_phy2)
[    2.862079] imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
[    2.872913] dwhdmi-imx 32fd8000.hdmi: registered DesignWare HDMI I2C bus driver
[    2.890637] imx-drm display-subsystem: bound imx-lcdifv3-crtc.0 (ops lcdifv3_crtc_ops)
[    2.898638] imx-drm display-subsystem: bound 32fd8000.hdmi (ops dw_hdmi_imx_ops)
[    2.906369] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsystem on minor 1
[    3.099104] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
[    3.207822] Console: switching to colour frame buffer device 240x67
[    3.230123] imx-drm display-subsystem: [drm] fb0: imx-drmdrmfb frame buffer device
[    3.358184] fec 30be0000.ethernet eth0: registered PHC device 0
[    3.366161] imx-dwmac 30bf0000.ethernet: User ID: 0x10, Synopsys ID: 0x51
[    3.373093] imx-dwmac 30bf0000.ethernet:     DWMAC4/5
[    3.377970] imx-dwmac 30bf0000.ethernet: DMA HW capability register supported
[    3.385215] imx-dwmac 30bf0000.ethernet: RX Checksum Offload Engine supported
[    3.392464] imx-dwmac 30bf0000.ethernet: TX Checksum insertion supported
[    3.399268] imx-dwmac 30bf0000.ethernet: Wake-Up On Lan supported
[    3.405508] imx-dwmac 30bf0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    3.413279] imx-dwmac 30bf0000.ethernet: Enabled L3L4 Flow TC (entries=8)
[    3.420176] imx-dwmac 30bf0000.ethernet: Enabled RFS Flow TC (entries=10)
[    3.427075] imx-dwmac 30bf0000.ethernet: Enabling HW TC (entries=256, max_off=256)
[    3.434760] imx-dwmac 30bf0000.ethernet: Using 34/40 bits DMA host/device width
[    3.571026] /soc@0/bus@30800000/ethernet@30bf0000/mdio/ethernet-phy@0: Fixed dependency cycle(s) with /soc@0/bus@30800000/ethernet@30bf0000/mdio/ethernet-phy@0/vddio-regulator
[    3.696098] mdio_bus stmmac-0: MDIO device at address 1 is missing.
[    3.705554] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    3.712242] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    3.720434] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe6d hci version 0x110 quirks 0x000000a001000010
[    3.730000] xhci-hcd xhci-hcd.0.auto: irq 222, io mem 0x38200000
[    3.736211] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    3.741783] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    3.749547] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    3.758271] hub 1-0:1.0: USB hub found
[    3.762413] hub 1-0:1.0: 1 port detected
[    3.768484] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.779568] hub 2-0:1.0: USB hub found
[    3.783409] hub 2-0:1.0: 1 port detected
[    3.789289] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 5 mkt segment 0 supported-hw 0x20 0x1
[    3.789497] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[    3.805828] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[    3.808712] sdhci-esdhc-imx 30b50000.mmc: Got CD GPIO
[    3.816838] ov5640 1-003c: supply DOVDD not found, using dummy regulator
[    3.825456] ov5640 1-003c: supply AVDD not found, using dummy regulator
[    3.832208] ov5640 1-003c: supply DVDD not found, using dummy regulator
[    3.851448] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
[    3.882316] ov5640 1-003c: ov5640_read_reg: error: reg=300a
[    3.887991] ov5640 1-003c: ov5640_check_chip_id: failed to read chip identifier
[    3.901233] ov5640_mainline 1-003c: supply DOVDD not found, using dummy regulator
[    3.911907] ov5640_mainline 1-003c: supply AVDD not found, using dummy regulator
[    3.922396] ov5640_mainline 1-003c: supply DVDD not found, using dummy regulator
[    3.971760] ov5640_mainline 1-003c: ov5640_write_reg: error: reg=3008, val=42
[    3.983686] ov5640_mainline 1-003c: ov5640_write_reg: error: reg=3103, val=11
[    3.994010] ov5640_mainline 1-003c: ov5640_read_reg: error: reg=3108
[    4.005327] ov5640_mainline 1-003c: failed to power on
[    4.013925] edt_ft5x06 1-0038: supply vcc not found, using dummy regulator
[    4.017392] ov5640 3-003c: supply DOVDD not found, using dummy regulator
[    4.023789] edt_ft5x06 1-0038: supply iovcc not found, using dummy regulator
[    4.026375] ov5640 3-003c: supply AVDD not found, using dummy regulator
[    4.028831] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    4.031355] ov5640 3-003c: supply DVDD not found, using dummy regulator
[    4.104058] imx6q-pcie 33800000.pcie: Phy link never came up
[    4.113787] ov5640 3-003c: ov5640_read_reg: error: reg=300a
[    4.122426] ov5640 3-003c: ov5640_check_chip_id: failed to read chip identifier
[    4.137345] ov5640_mainline 3-003c: supply DOVDD not found, using dummy regulator
[    4.148686] ov5640_mainline 3-003c: supply AVDD not found, using dummy regulator
[    4.159831] ov5640_mainline 3-003c: supply DVDD not found, using dummy regulator
[    4.212294] ov5640_mainline 3-003c: ov5640_write_reg: error: reg=3008, val=42
[    4.223713] ov5640_mainline 3-003c: ov5640_write_reg: error: reg=3103, val=11
[    4.234878] ov5640_mainline 3-003c: ov5640_read_reg: error: reg=3108
[    4.244274] hub 1-1:1.0: USB hub found
[    4.245429] ov5640_mainline 3-003c: failed to power on
[    4.247158] hub 1-1:1.0: 4 ports detected
[    4.260333] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    4.275648] isi-m2m 32e00000.isi:m2m_device: Register m2m success for ISI.0
[    4.285095] clk: Disabling unused clocks
[    4.296022] ALSA device list:
[    4.301290]   No soundcards found.
[    4.310656] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
[    4.351150] edt_ft5x06 1-0038: touchscreen probe failed
[    4.364642] hub 2-1:1.0: USB hub found
[    4.371072] hub 2-1:1.0: 4 ports detected
[    5.014926] usb 1-1.2: new low-speed USB device number 3 using xhci-hcd
[    5.106907] imx6q-pcie 33800000.pcie: Phy link never came up
[    5.116496] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
[    5.126470] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.135350] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    5.144843] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1fefffff]
[    5.155038] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    5.164372] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    5.172462] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.180784] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.188153] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.196478] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.205506] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.214864] pci 0000:00:00.0: supports D1
[    5.220951] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.231638] pci 0000:00:00.0: BAR 0 [mem 0x18000000-0x180fffff]: assigned
[    5.240541] pci 0000:00:00.0: ROM [mem 0x18100000-0x1810ffff pref]: assigned
[    5.249676] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.257298] pcieport 0000:00:00.0: PME: Signaling with IRQ 231
[    5.266527] Freeing unused kernel memory: 4352K
[    5.273200] Run /init as init process
```