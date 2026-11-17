# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="4.6.0"
PKG_SHA256="dc006756df7271d6138030e91dcc720a7d37b918cad7242bf986a08f9e671e80"
PKG_LICENSE="Unlicense AND BSD-2-Clause"
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
