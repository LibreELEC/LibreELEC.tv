# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wlopm"
PKG_VERSION="1.0.0"
PKG_SHA256="15f31bbd855131943397dded3a26003f2f5056e4c6a1a93d35ff7697b3f1e439"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://git.sr.ht/~leon_plickat/wlopm"
PKG_URL="https://git.sr.ht/~leon_plickat/wlopm/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols"
PKG_LONGDESC="Wayland output power management"
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  local wayland=$(get_install_dir wayland)
  CFLAGS+=" -I${wayland}/usr/include"
  LDFLAGS+=" -L${wayland}/usr/lib"
  make
  ${STRIP} wlopm
}

makeinstall_target() {
  :
}
