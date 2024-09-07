# RK3588

This is a work-in-progress SoC device for RK3588

**Known Issues/Limitations**

* no HDMI support
* uses rkbin ddr init blob instead of u-boot tpl
  - u-boot does not have any ddr init code
* uses rkbin atf blob
  - open source atf has not been tested
* ram is limited to ~4gb with `mem=3838M` (memory range `0x00200000` - `0xefffffff`)

**Build**

* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=cm3588-nas make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=nanopc-t6 make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=nanopi-r6c make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=nanopi-r6s make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=orangepi-5 make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=orangepi-5-plus make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=rock-5a make image`
* `PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 UBOOT_SYSTEM=rock-5b make image`
