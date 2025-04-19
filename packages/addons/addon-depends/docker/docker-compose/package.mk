# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="docker-compose"
PKG_VERSION="2.35.1"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/docker/compose"
PKG_LONGDESC="Define and run multi-container applications with Docker."
PKG_TOOLCHAIN="manual"

case ${ARCH} in
  x86_64)
    PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/docker-compose-linux-x86_64"
    PKG_SHA256="7bdb2ce2916e5dd0354e5d129892bf96fdcdb1a9ab8eed69b9173e131db4c230"
    ;;
  aarch64)
    PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/docker-compose-linux-aarch64"
    PKG_SHA256="a91e930a076b91e6c69f11d1dbe3c06729ae765fb9dbb3f97cb808e784647399"
    ;;
  arm)
    PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/docker-compose-linux-armv7"
    PKG_SHA256="50aba1c8fe1eb8efefede3dab9e6c2226ba756a5ffa5cf4f4f5baadaee9a7455"
    ;;
esac

PKG_SOURCE_NAME="docker-compose-linux-${ARCH}-${PKG_VERSION}"

unpack() {
  mkdir -p ${PKG_BUILD}
    cp -P ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} ${PKG_BUILD}/docker-compose
    chmod +x ${PKG_BUILD}/docker-compose
}
