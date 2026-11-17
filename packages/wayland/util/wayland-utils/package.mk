# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-utils"
PKG_VERSION="1.3.0"
PKG_SHA256="898ceff3007b11aaec5b13844ac673b99ee186b2706b9b2ab41ba6be8c29ad06"
PKG_LICENSE="MIT"
PKG_SITE="https://gitlab.freedesktop.org/wayland/wayland-utils"
PKG_URL="https://gitlab.freedesktop.org/wayland/wayland-utils/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols libdrm"
PKG_LONGDESC="wayland-utils contains wayland-info, which is a utility for displaying information about the Wayland protocols supported by the Wayland compositor."

if [ "${DISPLAYSERVER}" != "wl" ]; then
  PKG_BUILD_FLAGS="-sysroot"
  PKG_DEPENDS_CONFIG="wayland wayland-protocols"
fi

PKG_MESON_OPTS_TARGET="-Ddrm=enabled"
