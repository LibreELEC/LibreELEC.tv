# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pyelftools"
PKG_VERSION="0.31"
PKG_SHA256="24815cbfff9c5f68f5268983f55d969540a087bfdaa73c93f1a88e2a771f80f1"
PKG_LICENSE="Unlicense"
PKG_SITE="https://github.com/eliben/pyelftools"
PKG_URL="https://github.com/eliben/pyelftools/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="Library for analyzing ELF files and DWARF debugging information"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
