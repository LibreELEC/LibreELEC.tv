# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tmux"
PKG_VERSION="3.6a"
PKG_SHA256="b6d8d9c76585db8ef5fa00d4931902fa4b8cbe8166f528f44fc403961a3f3759"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/tmux/tmux/wiki"
PKG_URL="https://github.com/tmux/tmux/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libevent ncurses"
PKG_LONGDESC="tmux is a terminal multiplexer"
PKG_BUILD_FLAGS="-sysroot"
