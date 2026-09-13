# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="3.23.0"
PKG_SHA256="5a905f0f4237b79aefee47f3e04568db2ecb70c55dd7cb118974c5260aa9e285"
PKG_LICENSE="Unlicense AND BSD-2-Clause"
PKG_SITE="https://pypi.org/project/pycryptodome"
PKG_URL="https://github.com/Legrandin/${PKG_NAME}/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_DEPENDS_TARGET="toolchain Python3 setuptools:host"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_TOOLCHAIN="python"

pre_configure_host() {
  cd ${PKG_BUILD}
  rm -rf .${HOST_NAME}
}

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
