# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="swayidle"
PKG_VERSION="1.9.1"
PKG_SHA256="846372a151e9f65bbc50e86d600fc7d7f9e494c3e2fcbc23b4d1ead9a13bcd1e"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/swaywm/swayidle"
PKG_URL="https://github.com/swaywm/swayidle/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols"
PKG_DEPENDS_CONFIG="wayland wayland-protocols"
PKG_LONGDESC="Idle management daemon for Wayland"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled \
                       -Dlogind=disabled \
                       -Dzsh-completions=false \
                       -Dbash-completions=false \
                       -Dfish-completions=false"
