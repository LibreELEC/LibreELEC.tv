# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pluggy"
PKG_VERSION="fc40456932ec7fb258b0c48ef3789b7cd7747647"
PKG_SHA256="614a8426baa09a837cfa15bd5d842a4951e55c4f5b28d63fe87d3fe6677633a9"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/pytest-dev/pluggy"
PKG_URL="https://github.com/pytest-dev/pluggy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="A minimalist production ready plugin system"
PKG_TOOLCHAIN="python"

pre_configure_host() {
  export SETUPTOOLS_SCM_PRETEND_VERSION=${PKG_VERSION}
}
