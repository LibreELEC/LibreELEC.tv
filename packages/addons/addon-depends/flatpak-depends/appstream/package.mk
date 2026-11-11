# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="appstream"
PKG_VERSION="1.2.3"
PKG_SHA256="12f01e127081c485a3e3056b6d30f54d003101689ff815adac6f1ef2b19af6ab"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/ximion/appstream"
PKG_URL="https://github.com/ximion/appstream/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host curl:host itstool:host libfyaml:host libxml2:host libxmlb:host"
PKG_DEPENDS_TARGET="toolchain appstream:host curl glib libfyaml libxml2 libxmlb xz zstd"
PKG_DEPENDS_CONFIG="libfyaml libxmlb"
PKG_LONGDESC="Tools and libraries to work with AppStream metadata"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_HOST="-Dstemming=false \
                     -Dsystemd=false \
                     -Dbash-completion=false \
                     -Dgir=false \
                     -Ddisplay-detection=none \
                     -Dzstd-support=false \
                     -Ddocs=false \
                     -Dapidocs=false \
                     -Dman=false"

PKG_MESON_OPTS_TARGET="-Dstemming=false \
                       -Dbash-completion=false \
                       -Dsystemd=false \
                       -Dgir=false \
                       -Ddisplay-detection=none \
                       -Dzstd-support=true \
                       -Ddocs=false \
                       -Dapidocs=false \
                       -Dman=false"

pre_configure_host() {
  export PKG_CONFIG_PATH="$(get_build_dir curl)/.host-install/lib/pkgconfig"
}

pre_configure_target() {
  export TARGET_LDFLAGS+=" -lm"
}
