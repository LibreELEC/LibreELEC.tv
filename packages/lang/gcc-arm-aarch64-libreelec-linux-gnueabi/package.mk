# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-aarch64-libreelec-linux-gnueabi"
PKG_VERSION="10.2.0-0"
PKG_SHA256="28520f3580b94ebd34a2ca2ca13c7db547862034ad8cfd4cb0e193e6aa9280ac"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.git"
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_LONGDESC="ARM Aarch64 GNU LibreELEC Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

pre_build_host() {
  if [ "$(get_pkg_variable gcc PKG_VERSION)" != "${PKG_VERSION%%-*}" ]; then
    print_color CLR_WARNING "WARNING: version mismatch: gcc: $(get_pkg_variable gcc PKG_VERSION) ${PKG_NAME}: ${PKG_VERSION%%-*}\n"
  fi
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/${PKG_NAME}
    cp -a * ${TOOLCHAIN}/lib/${PKG_NAME}/

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="${TOOLCHAIN}/lib/${PKG_NAME}/bin/aarch64-libreelec-linux-gnueabi-"

cat > "${PKG_GCC_PREFIX}gcc" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${PKG_GCC_PREFIX}gcc-${PKG_VERSION%%-*} "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}gcc"

cat > "${PKG_GCC_PREFIX}g++" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${PKG_GCC_PREFIX}g++-${PKG_VERSION%%-*} "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}g++"
}
