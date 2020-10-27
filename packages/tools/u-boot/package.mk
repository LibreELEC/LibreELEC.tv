# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot"
PKG_VERSION="v2020.10"
PKG_SHA256="0c022ca6796aa8c0689faae8b515eb62ac84519c31de3153257a9ee0f446618f"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/u-boot/u-boot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3:host swig:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

PKG_STAMP="$UBOOT_SYSTEM $UBOOT_TARGET"

[ -n "$KERNEL_TOOLCHAIN" ] && PKG_DEPENDS_TARGET+=" gcc-arm-$KERNEL_TOOLCHAIN:host"

if [ -n "$UBOOT_FIRMWARE" ]; then
  PKG_DEPENDS_TARGET+=" $UBOOT_FIRMWARE"
  PKG_DEPENDS_UNPACK+=" $UBOOT_FIRMWARE"
fi

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"
[ -n "$DEVICE" ] && PKG_NEED_UNPACK+=" $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader"

post_patch() {
  if [ -n "$UBOOT_SYSTEM" ] && find_file_path bootloader/config; then
    PKG_CONFIG_FILE="$PKG_BUILD/configs/$($ROOT/$SCRIPTS/uboot_helper $PROJECT $DEVICE $UBOOT_SYSTEM config)"
    if [ -f "$PKG_CONFIG_FILE" ]; then
      cat $FOUND_PATH >> "$PKG_CONFIG_FILE"
    fi
  fi
}

make_target() {
  if [ -z "$UBOOT_SYSTEM" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
  else
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm make mrproper
    [ -n "$UBOOT_FIRMWARE" ] && find_file_path bootloader/firmware && . ${FOUND_PATH}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm make $($ROOT/$SCRIPTS/uboot_helper $PROJECT $DEVICE $UBOOT_SYSTEM config)
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm _python_sysroot="$TOOLCHAIN" _python_prefix=/ _python_exec_prefix=/ make $UBOOT_TARGET HOSTCC="$HOST_CC" HOSTLDFLAGS="-L$TOOLCHAIN/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    if [ -n "$UBOOT_SYSTEM" ]; then
      find_file_path bootloader/install && . ${FOUND_PATH}
    fi

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

    # Always install the canupdate script
    if find_file_path bootloader/canupdate.sh; then
      cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-$PROJECT}/g" \
          -i $INSTALL/usr/share/bootloader/canupdate.sh
    fi
}
