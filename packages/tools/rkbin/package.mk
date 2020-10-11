# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"
PKG_VERSION="d0a1bdc3333ef24ccc592bb39f31f2bf42be6e79"
PKG_SHA256="26d7baf7b76b9fa3fed9133a77fde73094c051119df474e75dd1520bc0d53626"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/rkbin"
PKG_URL="https://github.com/rockchip-linux/rkbin/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_DEPENDS_TARGET="rkbin-extra"
PKG_DEPENDS_UNPACK="rkbin-extra"
PKG_TOOLCHAIN="manual"
PKG_STAMP="$UBOOT_SYSTEM"

[ -n "$KERNEL_TOOLCHAIN" ] && PKG_DEPENDS_TARGET+=" gcc-arm-$KERNEL_TOOLCHAIN:host"

pre_build_target() {
  cp -a $(get_build_dir rkbin-extra)/* $PKG_BUILD
}

make_target() {
  case "$DEVICE" in
    RK3288)
      # Use vendor ddr init and miniloader blob
      #cp -av bin/rk32/rk3288_ddr_400MHz_v1.08.bin ddr.bin
      #cp -av bin/rk32/rk3288_miniloader_v2.58.bin miniloader.bin

      # Make tee.bin available for u-boot fit-image
      #cp -av bin/rk32/rk3288_tee_ta_v2.01.bin tee.bin

      # Build trust.img for use with miniloader blob
      #tools/loaderimage --pack --trustos tee.bin trust.img 0x68400000
      ;;
    RK3328)
      # Use vendor ddr init and miniloader blob
      if [ "$UBOOT_SYSTEM" = "roc-cc" -o "$UBOOT_SYSTEM" = "box-trn9" ]; then
        cp -av bin/rk33/rk3328_ddr_933MHz_v1.16.bin ddr.bin
      else
        cp -av bin/rk33/rk3328_ddr_786MHz_v1.16.bin ddr.bin
      fi
      #cp -av bin/rk33/rk322xh_miniloader_v2.50.bin miniloader.bin

      # Build trust.img for use with miniloader blob
      #tools/trust_merger --ignore-bl32 --verbose RKTRUST/RK3328TRUST.ini

      # Make bl31 and bl32 available for u-boot fit-image
      cp -av bin/rk33/rk322xh_bl31_v1.44.elf bl31.elf
      #cp -av bin/rk33/rk322xh_bl32_v2.01.bin bl32.bin
      ;;
    RK3399)
      # Use vendor ddr init and miniloader blob
      #cp -av bin/rk33/rk3399_ddr_800MHz_v1.24.bin ddr.bin
      #cp -av bin/rk33/rk3399_miniloader_v1.26.bin miniloader.bin

      # Build trust.img for use with miniloader blob
      #tools/trust_merger --ignore-bl32 --verbose RKTRUST/RK3399TRUST.ini

      # Make bl31 and bl32 available for u-boot fit-image
      cp -av bin/rk33/rk3399_bl31_v1.35.elf bl31.elf
      #cp -av bin/rk33/rk3399_bl32_v2.01.bin bl32.bin
      ;;
  esac

  if [ -f bl32.bin ]; then
    ${TARGET_KERNEL_PREFIX}objcopy -B aarch64 -I binary -O elf64-littleaarch64 bl32.bin bl32.o
    ${TARGET_KERNEL_PREFIX}ld bl32.o -T tee.ld -o tee.elf
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/.noinstall
  for PKG_FILE in bl31.elf tee.elf tee.bin ddr.bin miniloader.bin; do
    if [ -f $PKG_FILE ]; then
      cp -av $PKG_FILE $INSTALL/.noinstall
    fi
  done

  if [ -f trust.img ]; then
    mkdir -p $INSTALL/usr/share/bootloader
    cp -av trust.img $INSTALL/usr/share/bootloader
  fi
}
