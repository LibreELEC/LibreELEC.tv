# Mediatek Genio

Support for the MT8395 SoC

**Build**

* `PROJECT=Mediatek DEVICE=Genio ARCH=aarch64 DTB=mt8395-radxa-nio-12l UBOOT_SYSTEM=nio-12l make image`


## Audio

- `pactl set-default-sink alsa_output.0.HiFi__HDMI1__sink` for HDMI audio
