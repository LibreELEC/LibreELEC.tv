# SPDX-License-Identifier: GPL-2.0-only
# Sourced by initramfs mount_storage() when /flash/mount-storage.sh exists
# and disk= is set. eMMC only: writable ext4 STORAGE (not squashfs, not tmpfs).
# SD overlay leaves disk= unset on purpose so /storage stays tmpfs.

# Prefer the cmdline disk= (UUID=… from make image, or LABEL=STORAGE).
if [ -n "$disk" ] && mount -o rw,noatime "$disk" /storage >/dev/null 2>&1; then
  return 0
fi

if mount -o rw,noatime LABEL=STORAGE /storage >/dev/null 2>&1; then
  return 0
fi

# Same disk as /flash, partition 2. This board's eMMC is mmcblk2.
flash_dev="$(awk '$2=="/flash"{print $1; exit}' /proc/mounts)"
storage_dev=""
case "$flash_dev" in
  *p[0-9]) storage_dev="${flash_dev%p*}p2" ;;
  *[0-9])  storage_dev="${flash_dev%%[0-9]*}2" ;;
esac
[ -n "$storage_dev" ] || storage_dev="/dev/mmcblk2p2"

mount_part "$storage_dev" "/storage" "rw,noatime"
