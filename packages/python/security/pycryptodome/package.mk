# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="3.22.0"
PKG_SHA256="d1499d50dfe0628fe45157956e9c522011f37043a2d3f2457631c97e56f9e6c1"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/pycryptodome"
PKG_URL="https://github.com/Legrandin/${PKG_NAME}/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 setuptools:host"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_TOOLCHAIN="python"

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

post_makeinstall_target() {
  # Remove SelfTest bloat
  find ${INSTALL} -type d -name SelfTest -exec rm -fr "{}" \; 2>/dev/null || true
  find ${INSTALL} -name SOURCES.txt -exec sed -i "/\/SelfTest\//d;" "{}" \;

  # Create Cryptodome as an alternative namespace to Crypto (Kodi addons may use either)
  ln -sf /usr/lib/${PKG_PYTHON_VERSION}/site-packages/Crypto ${INSTALL}/usr/lib/${PKG_PYTHON_VERSION}/site-packages/Cryptodome

  python_remove_source
}
