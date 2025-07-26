# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libsodium"
PKG_VERSION="1.0.20"
PKG_SHA256="ebb65ef6ca439333c2bb41a0c1990587288da07f6c7fd07cb3a18cc18d30ce19"
PKG_LICENSE="ISC"
PKG_SITE="https://libsodium.org/"
PKG_URL="https://github.com/jedisct1/libsodium/releases/download/${PKG_VERSION}-RELEASE/libsodium-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A modern, portable, easy to use crypto library"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared"
