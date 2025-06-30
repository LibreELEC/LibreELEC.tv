# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glycin"
PKG_VERSION="2.0.beta.3"
PKG_SHA256="52a45b324b65939096f73cfbea9709ee2a3590e1c833edb46628583cd1d2c033"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://gitlab.gnome.org/GNOME/glycin/-/archive/${PKG_VERSION}/glycin-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain cargo:host fontconfig libseccomp lcms2 glib"
PKG_LONGDESC="Sandboxed and extendable image loading"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_PROPERTIES_TARGET="skip_sanity_check = true"

PKG_MESON_OPTS_TARGET="--wrap-mode=nodownload \
                       -Dglycin-loaders=false \
                       -Dlibglycin-gtk4=false \
                       -Dintrospection=false \
                       -Dtests=false \
                       -Dglycin-thumbnailer=false \
                       -Dvapi=false"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libX11"
fi

pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_install_dir libseccomp)/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
  #export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=${TARGET_CC}
  #export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=${TARGET_CC}

  case "${ARCH}" in
    "aarch64")
      RUST_TARGET="aarch64-libreelec-linux-gnu.json"
      ;;
    "arm")
      RUST_TARGET="armv7ve-libreelec-linux-gnueabihf.json"
      ;;
    "x86_64")
      RUST_TARGET="x86_64-libreelec-linux-gnu.json"
      ;;
  esac

  mkdir cargo-home
  cat > cargo-home/config.toml <<EOF
[build]
target="${TOOLCHAIN}/lib/rustlib/${RUST_TARGET}"
EOF
}
