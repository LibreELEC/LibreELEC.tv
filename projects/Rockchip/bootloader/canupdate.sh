# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# detect legacy kernel installs and abort to prevent upgrades
case $(uname -r) in
  4.4*)
    echo "Updates from legacy kernels are not supported!"
    sleep 10
    exit 1
    ;;
esac

# Allow upgrades between arm and aarch64
if [ "$1" = "@TARGET_SYSTEM@.arm" -o "$1" = "@TARGET_SYSTEM@.aarch64" ]; then
  exit 0
else
  exit 1
fi
