# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="image"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://libreelec.tv"
PKG_DEPENDS_TARGET="toolchain squashfs-tools:host pigz:host dosfstools:host fakeroot:host kmod:host mtools:host e2fsprogs:host libc gcc linux linux-drivers linux-firmware ${BOOTLOADER} busybox util-linux corefonts network misc-packages debug hdparm parted dosfstools e2fsprogs exfatprogs usbutils procps-ng"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build and create complete image"

# nano text editor
[ "${NANO_EDITOR}" = "yes" ] && PKG_DEPENDS_TARGET+=" nano"

# Graphic support
if [ "${DISPLAYSERVER}" = "no" ]; then
   PKG_DEPENDS_TARGET+=" gbm"
else
   PKG_DEPENDS_TARGET+=" ${DISPLAYSERVER}"
fi

# Multimedia support
[ ! "${MEDIACENTER}" = "no" ] && PKG_DEPENDS_TARGET+=" mediacenter"

# Sound support
[ "${ALSA_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" alsa"

[ "${PULSEAUDIO_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" pulseaudio"

[ "${PIPEWIRE_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" pipewire wireplumber"

if [ "${PULSEAUDIO_SUPPORT}" = "yes" -a "${PIPEWIRE_SUPPORT}" = "yes" ]; then
  die "PULSEAUDIO_SUPPORT and PIPEWIRE_SUPPORT cannot be enabled together"
fi

# Automounter support
[ "${UDEVIL}" = "yes" ] && PKG_DEPENDS_TARGET+=" udevil"

# Remote support
[ "${REMOTE_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" remote"

# Virtual image creation support
[ "${PROJECT}" = "Generic" ] && PKG_DEPENDS_TARGET+=" virtual"

# Installer support
[ "${INSTALLER_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" installer"

# Devtools... (not for Release)
[ "${TESTING}" = "yes" ] && PKG_DEPENDS_TARGET+=" testing"

# OEM packages
[ "${OEM_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" oem"

# NTFS programs for all except RPi until RPi is updated to kernel > 6.18
[ ! "${PROJECT}" = "RPi" ] && PKG_DEPENDS_TARGET+=" ntfsprogs-plus"

true
