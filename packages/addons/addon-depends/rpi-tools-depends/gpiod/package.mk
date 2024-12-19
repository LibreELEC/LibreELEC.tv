# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpiod"
PKG_VERSION="2.2.2"
PKG_SHA256="aa4571f64e1070d38e4c14c491f69637ee73e23c801d3a418dde4d5410e5d53f"
PKG_ARCH="arm aarch64"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://pypi.org/project/gpiod/"
PKG_URL="https://files.pythonhosted.org/packages/source/g/gpiod/gpiod-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="These are the official Python bindings for libgpiod."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
  export LDSHARED="${CC} -shared"
  export CFLAGS="${CFLAGS} -fcommon"
  export CPPFLAGS="${TARGET_CPPFLAGS} -I${SYSROOT_PREFIX}/usr/include/${PKG_PYTHON_VERSION}"
}

make_target() {
  python3 setup.py build
}
