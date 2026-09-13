# imx-boot / flash.bin

Primary path is a **source build** via Variscite [imx-mkimage](https://github.com/varigit/imx-mkimage/tree/lf-6.18.20_2.0.0_var01/iMX8M)
`iMX8M/` (`SOC=iMX8MP flash_evk`):

```
PROJECT=NXP DEVICE=VAR-DART-IMX8MP ARCH=aarch64 UBOOT_SYSTEM=imx8mp-var-dart \
  ./scripts/build u-boot
```

Inputs:

- `sigysmund/uboot-imx` (`imx8mp_var_dart_defconfig`) → `u-boot.bin`, `u-boot-nodtb.bin`, `spl/u-boot-spl.bin`, DTB
- LE `atf` (`PLAT=imx8mp`, `SPD=opteed`, UART1 / `0x30860000`) → `bl31.bin`
- NXP `imx-optee-os` (`PLATFORM=imx-mx8mpevk`, 4 GiB, UART1) → `tee.bin`
- NXP `firmware-imx` LPDDR4 `_202006` training bins (not installed into SYSTEM)

Output: `build.*/u-boot-*/flash.bin`. `pack-uuu-bundle.sh` prefers that file.

A blob in this directory is only an emergency fallback and is gitignored.

Do **not** use `iMX8QX/` (SCU + AHAB + `scfw_tcm.bin`). That is i.MX8QuadXPlus.

NXP HDMI/XCVR/VPU/codec firmware stays in `firmware-imx` on SYSTEM. Those are
required to load the HW; they are not a substitute for building U-Boot.
