# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa-reusable"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="manual"

MESA_VERSION=$(get_pkg_version mesa)
PKG_VERSION="${OS_VERSION}-${MESA_VERSION}"
PKG_SOURCE_NAME="${PKG_NAME}-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}.tar"
PKG_URL="https://github.com/LibreELEC/mesa-reusable/releases/download/${PKG_VERSION}/${PKG_SOURCE_NAME}"
PKG_SHA256="$(curl --fail --connect-timeout 30 --retry 3 --location --max-redirs 5 ${PKG_URL}.sha256)"

unpack() {
  mkdir -p ${TOOLCHAIN}/bin
  tar -xf ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} -C ${TOOLCHAIN}/bin
}
