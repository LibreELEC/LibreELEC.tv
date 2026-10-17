# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Variscite imx-mkimage. DART-MX8MP is i.MX8M Plus: use iMX8M/ with
# SOC=iMX8MP. Do not use iMX8QX (SCU + AHAB, Cortex-A35).

PKG_NAME="imx-mkimage"
PKG_VERSION="e877d8119d4599fb068f4599e6f22e2f4fcb593b"
PKG_SHA256="b8f1113201a65942eb1dc15efa723fa96d09b2e1cfd75b558080c8b9834962e1"
PKG_ARCH="aarch64"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/varigit/imx-mkimage"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib:host"
PKG_LONGDESC="Variscite imx-mkimage lf-6.18.20_2.0.0_var01. Assembles flash.bin for i.MX8M (not i.MX8QX)."
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}

make_target() {
  : # invoked from u-boot via iMX8M/soc.mak SOC=iMX8MP flash_evk
}

makeinstall_target() {
  :
}
