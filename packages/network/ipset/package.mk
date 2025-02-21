# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ipset"
PKG_VERSION="7.23"
PKG_SHA256="db3a51a9ebf27c7cbd0a1482c46c5e0ed630c28c796f73287c4b339dd46086e5"
PKG_LICENSE="GPL"
PKG_SITE="https://ipset.netfilter.org"
PKG_URL="https://ipset.netfilter.org/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="libmnl"
PKG_LONGDESC="IP sets are a framework inside the Linux kernel, which can be administered by the ipset utility"
PKG_IS_KERNEL_PKG="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-kbuild=$(kernel_path)"
