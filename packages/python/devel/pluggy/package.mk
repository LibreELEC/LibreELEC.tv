# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pluggy"
PKG_VERSION="1.5.0"
PKG_SHA256="6e9b6c46ae3b0c82087df05d866a8ba2787480dfb2c93b51b78ffc15deaf51b9"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/pytest-dev/pluggy"
PKG_URL="https://github.com/pytest-dev/pluggy/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="A minimalist production ready plugin system"
PKG_TOOLCHAIN="python"

pre_configure_host() {
  export SETUPTOOLS_SCM_PRETEND_VERSION=${PKG_VERSION}
}
