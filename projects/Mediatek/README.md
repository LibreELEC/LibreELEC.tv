# Mediatek

This project is for Mediatek SoC devices

## Devices

**Genio 1200 / MT8395**
* [Radxa NIO-12L](devices/Genio)

## Useful debug commands

* `cat /sys/kernel/debug/dri/0/state`
* `cat /sys/kernel/debug/dri/0/framebuffer`
* `cat /sys/kernel/debug/dma_buf/bufinfo`
* `cat /sys/kernel/debug/cec/cec0/status`
* `hexdump -C /sys/class/drm/card0-HDMI-A-1/edid`
* `edid-decode /sys/class/drm/card0-HDMI-A-1/edid`
* `cat /sys/kernel/debug/clk/clk_summary`
* `cat /sys/kernel/debug/regulator/regulator_summary`
