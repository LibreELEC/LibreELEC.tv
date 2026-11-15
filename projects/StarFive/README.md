# StarFive

This project is for StarFive JH7110 SoC devices

## Devices

**JH7110**
* [StarFive VisionFive 2](devices/JH7110) (v1.2a, v1.3b)
* [StarFive VisionFive 2 Lite](devices/JH7110) (JH7110S, microSD and eMMC versions)

## Booting

The JH7110 boot ROM loads U-Boot from the SPI flash, the SD card or the eMMC,
selected by the boot mode pins RGPIO1:RGPIO0. U-Boot then starts LibreELEC
from the SD card.

| Board | Boot mode selection | SD card boot mode |
| :--- | :--- | :--- |
| VisionFive 2 | DIP switches | yes (RGPIO1:0 = 0:1) |
| VisionFive 2 Lite | *Boot* key: released = SPI flash, held at power on = UART | no |

The VisionFive 2 Lite always boots the U-Boot in its SPI flash. The SD card
boot mode of the VisionFive 2 is deprecated in U-Boot and does not work with
every card, so booting from the SPI flash is the recommended way on both
boards.

The same image boots from a microSD card, an eMMC module or an NVMe drive
in the M.2 slot. Except for the SD card boot mode of the VisionFive 2, that
needs a U-Boot in the SPI flash; it prefers the microSD card when one is
inserted. The eMMC boot mode does not work, the boot ROM expects the SPL in
sector 0 there. The image works with both U-Boot versions in the SPI flash:

* **StarFive vendor U-Boot** (as shipped): it only looks at GPT partition 3.
  Every SDK release loads `vf2_uEnv.txt` from there and runs its `boot2`,
  which sources `boot.scr`. That script loads the kernel and the device tree
  from the system partition and reads the kernel command line from
  `uEnv.ini`. The VisionFive 2 Lite is detected automatically. The
  VisionFive 2 uses the vendor `fdtfile` when the image has a device tree of
  that name, otherwise the v1.3b one; for a v1.2a board, set it once with
  `setenv fdtfile jh7110-starfive-visionfive-2-v1.2a.dtb; saveenv`. If the
  board stops at the `StarFive #` prompt because a changed environment was
  saved before, restore the defaults with `env default -f -a; saveenv`.
* **LibreELEC (mainline) U-Boot**: it selects the device tree from the board
  EEPROM and boots `extlinux/extlinux.conf` from the system partition. This
  is the recommended setup.

### Writing the LibreELEC U-Boot to the SPI flash

The image ships the U-Boot for the SPI flash in `/spi` on the system
partition, together with `flash-spi.scr`, which writes it to the flash.
LibreELEC updates the files in `/spi`, but it never writes the SPI flash
itself. Rerun the script by hand to update the U-Boot in the flash.

1. Connect a 3.3 V USB serial adapter to the debug UART on the 40 pin header
   (115200 8N1).
2. Power on the board and press a key to stop autoboot.
3. Run (`mmc 0:1` is the microSD slot of the VisionFive 2 Lite; use
   `mmc 1:1` for the microSD slot of the VisionFive 2):

   ```
   load mmc 0:1 ${scriptaddr} /spi/flash-spi.scr; source ${scriptaddr}
   ```

   If `load` cannot find the file, try the other mmc device. The script
   finds `/spi` on either device by itself.

4. Wait for `flash-spi: done`, then power cycle the board.

The script reads both files before it writes anything. Do not power off the
board while it writes the flash.

### Recovering the SPI flash

If the board no longer starts U-Boot, restore the vendor bootloader over UART:
hold the *Boot* key (VisionFive 2 Lite) or set the DIP switches to UART mode
(VisionFive 2) while powering on. Then send the recovery image and the SDK
bootloader with XMODEM, see the [StarFive recovery
guide](https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/VisionFive2_SDK_QSGLite/recovering_bootloader%20-%20vf2lite.html).

### SD card layout

| GPT | Name | Location | Contents |
| :--- | :--- | :--- | :--- |
| 5 | spl | 2 MiB .. 4 MiB | `u-boot-spl.bin.normal.out` (SD card boot mode only) |
| 4 | uboot | 4 MiB .. 8 MiB | `u-boot.itb`, OpenSBI + U-Boot (SD card boot mode only) |
| 3 | boot | 8 MiB .. 16 MiB | FAT `BOOT`: `vf2_uEnv.txt` and `boot.scr` for the vendor U-Boot |
| 1 | system | 16 MiB .. | FAT: `KERNEL`, `SYSTEM`, `extlinux/`, `uEnv.ini`, `starfive/*.dtb`, `spi/` |
| 2 | storage | .. end | ext4, resized on first boot |

## Links

* https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
* https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html
