# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nftables"
PKG_VERSION="1.1.5"
PKG_SHA256="1daf10f322e14fd90a017538aaf2c034d7cc1eb1cc418ded47445d714ea168d4"
PKG_LICENSE="GPL"
PKG_SITE="https://netfilter.org/projects/${PKG_NAME}"
PKG_URL="https://netfilter.org/projects/${PKG_NAME}/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="autotools:host gcc:host libnftnl readline"
PKG_LONGDESC="A userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem."

PKG_CONFIGURE_OPTS_TARGET="--without-cli --with-mini-gmp"
