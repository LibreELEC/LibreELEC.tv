# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rust"
PKG_VERSION="nightly"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_DEPENDS_TARGET="toolchain rustup.rs"
PKG_LONGDESC="A systems programming language that prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

make_target() {
  export CARGO_HOME="${PKG_BUILD}/cargo"
  export RUSTUP_HOME="${CARGO_HOME}"
  export PATH="${CARGO_HOME}/bin:${PATH}"
  case "${TARGET_ARCH}" in
    aarch64)
      RUST_TARGET_TRIPLE="aarch64-unknown-linux-gnu"
      ;;
    arm)
      RUST_TARGET_TRIPLE="arm-unknown-linux-gnueabihf"
      ;;
    x86_64)
      RUST_TARGET_TRIPLE="x86_64-unknown-linux-gnu"
      ;;
  esac
  "$(get_build_dir rustup.rs)/rustup-init.sh" \
    --default-toolchain none \
    --no-modify-path \
    --profile minimal \
    --target "${RUST_TARGET_TRIPLE}" \
    -y
  cargo/bin/rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

  cat <<EOF >"${CARGO_HOME}/config"
[build]
target = "${RUST_TARGET_TRIPLE}"

[target.${RUST_TARGET_TRIPLE}]
ar = "${AR}"
linker = "${CC}"
EOF

  cat <<EOF >"${CARGO_HOME}/env"
export CARGO_HOME="${CARGO_HOME}"
export CARGO_TARGET_DIR="\${PKG_BUILD}/.\${TARGET_NAME}"
if [ "${HOSTTYPE}" = "${TARGET_ARCH}" ]; then
  export CARGO_TARGET_APPLIES_TO_HOST="false"
  export CARGO_Z_TARGET_APPLIES_TO_HOST="-Z target-applies-to-host"
fi
export PATH="${CARGO_HOME}/bin:${PATH}"
export PKG_CONFIG_ALLOW_CROSS="1"
export PKG_CONFIG_PATH="${PKG_CONFIG_LIBDIR}"
export RUSTUP_HOME="${CARGO_HOME}"
unset CFLAGS
EOF
}
