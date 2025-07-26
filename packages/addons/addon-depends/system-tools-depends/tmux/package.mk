# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tmux"
PKG_VERSION="3.5a"
PKG_SHA256="16216bd0877170dfcc64157085ba9013610b12b082548c7c9542cc0103198951"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/tmux/tmux/wiki"
PKG_URL="https://github.com/tmux/tmux/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libevent ncurses"
PKG_LONGDESC="tmux is a terminal multiplexer"
PKG_BUILD_FLAGS="-sysroot"
