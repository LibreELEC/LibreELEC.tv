# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-common"
PKG_VERSION="0a2b63d903ea0cc7bac9e759af57db190b4aeadd"
PKG_SHA256="cdeba2574bf659cd5b7bff6b4a6fcbe827d93d1beb8cf1ccc598836b25c75852"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-common"
PKG_URL="https://github.com/libretro/libretro-common/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Reusable coding blocks useful for libretro core and frontend development"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${SYSROOT_PREFIX}/usr/include/${PKG_NAME}"
  cp -pR ${PKG_BUILD}/include/* "${SYSROOT_PREFIX}/usr/include/${PKG_NAME}/"
}
