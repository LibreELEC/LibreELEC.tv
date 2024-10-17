# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="patchelf"
PKG_VERSION="0.18.0"
PKG_SHA256="1952b2a782ba576279c211ee942e341748fdb44997f704dd53def46cd055470b"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/NixOS/patchelf"
PKG_URL="https://github.com/NixOS/patchelf/releases/download/${PKG_VERSION}/patchelf-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="autotools:host"
PKG_LONGDESC="A small utility to modify the dynamic linker and RPATH of ELF executables"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs:host"
