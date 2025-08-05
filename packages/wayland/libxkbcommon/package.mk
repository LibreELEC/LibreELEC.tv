# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxkbcommon"
PKG_VERSION="9d4885dfb920c79fa157e0c990c63aa6896fc006"
PKG_SHA256="16d6a02e80193778a2048c7db16d33d3637bc1434e9fba7e35c372ffdd84a373"
PKG_LICENSE="MIT"
PKG_SITE="https://xkbcommon.org"
PKG_URL="https://github.com/xkbcommon/libxkbcommon/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain xkeyboard-config libxml2"
PKG_LONGDESC="xkbcommon is a library to handle keyboard descriptions."

PKG_MESON_OPTS_TARGET="-Denable-docs=false"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=true \
                           -Denable-wayland=false"
elif [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                           -Denable-wayland=true"
else
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                           -Denable-wayland=false"
fi

pre_configure_target() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    TARGET_LDFLAGS="${LDFLAGS} -lXau -lxcb"
  fi
}
