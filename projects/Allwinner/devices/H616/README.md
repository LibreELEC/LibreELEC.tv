# H616

Support for the Allwinner H616/H618/H313 SoC family (display, video engine
and deinterlace, audio hub and HDMI audio, second Ethernet MAC).

**Build**

* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=orangepi-zero2 make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=orangepi-zero2w make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=orangepi-zero3 make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=transpeed-8k618-t make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=x96-mate make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=x96q make image`
* `PROJECT=Allwinner DEVICE=H616 ARCH=aarch64 UBOOT_SYSTEM=yuzukihd-chameleon make image`

Excluded from this device: the Anbernic handhelds (H700, out of scope here),
BigTreeTech CB1/Pi and LonganPi boards (no U-Boot defconfig at the time this
was written), and the X96Q Pro+ (its H728 SoC belongs to the A523 family,
not H616).
