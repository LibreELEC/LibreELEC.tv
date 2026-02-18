# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libyaml"
PKG_VERSION="0.2.5"
PKG_SHA256="c642ae9b75fee120b2d96c712538bd2cf283228d2337df2cf2988e3c02678ef4"
PKG_LICENSE="MIT"
PKG_SITE="http://pyyaml.org/wiki/LibYAML"
PKG_URL="http://pyyaml.org/download/libyaml/yaml-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="LibYAML is a YAML parser and emitter library"
PKG_BUILD_FLAGS="-sysroot -cfg-libs"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
