# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cargo"
PKG_VERSION="$(get_pkg_version rust)"
PKG_LICENSE="MIT OR Apache-2.0"
PKG_SITE="https://www.rust-lang.org"
PKG_DEPENDS_HOST="openssl:host rust:host"
PKG_DEPENDS_UNPACK="cargo-snapshot rust"
PKG_LONGDESC="Cargo is the Rust package manager"
PKG_TOOLCHAIN="manual"

# with a reusable rust, cargo comes from the same archive
if [ "$(get_pkg_variable rust PKG_REUSABLE)" = "yes" ]; then
  PKG_SECTION="virtual"
  PKG_DEPENDS_UNPACK=""
fi

pre_configure_host() {
  # say why cargo:host is being built when a reusable archive was preferred
  if [ "${USE_REUSABLE}" = "preferred" ]; then
    build_msg "CLR_WARNING" "WARNING" \
      "$(get_pkg_variable rust PKG_REUSABLE_SOURCE_NAME) is not available, building cargo:host"
  fi

  "$(get_build_dir cargo-snapshot)/install.sh" --prefix="${PKG_BUILD}/cargo-snapshot" --disable-ldconfig
}

configure_host() {
  cd ${PKG_BUILD}
}

make_host() {
  cd ${PKG_BUILD}

  export RUSTC_BOOTSTRAP="1"

  ./cargo-snapshot/bin/cargo build -v --target ${RUST_HOST} --release --manifest-path="$(get_build_dir rust)/src/tools/cargo/Cargo.toml"
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp -a ${PKG_BUILD}/.${RUST_HOST}/target/${RUST_HOST}/release/cargo ${TOOLCHAIN}/bin/

  if listcontains "${BUILD_REUSABLE}" "(all|cargo:host)"; then
    save_rust_reusable
  fi
}

# pack rust:host and cargo:host as the cargo-reusable archive
save_rust_reusable() {
  local stage2="$(get_build_dir rust)/build/${RUST_HOST}/stage2"
  local name="cargo-reusable-$(get_pkg_variable rust PKG_REUSABLE_VERSION)"
  local dir="${PKG_BUILD}/.reusable/${name}"
  local pkg

  rm -rf "${PKG_BUILD}/.reusable"
  mkdir -p "${dir}/bin" "${dir}/lib"
    cp -a "${stage2}"/bin/{rustc,rustdoc} "${dir}/bin"
    cp -a ${PKG_BUILD}/.${RUST_HOST}/target/${RUST_HOST}/release/cargo "${dir}/bin"
    cp -a "${stage2}"/lib/* "${dir}/lib"

  # the source links point back into the rust build directory
  safe_remove "${dir}"/lib/rustlib/{src,rustc-src}

  # find openssl from the toolchain the archive is unpacked into
  patchelf --set-rpath '$ORIGIN/../lib' "${dir}/bin/cargo"

  {
    echo "archive: $(get_pkg_variable rust PKG_REUSABLE_SOURCE_NAME)"
    echo "host: ${RUST_HOST}"
    echo "target: ${TARGET_NAME}"
    for pkg in rust cargo llvm gcc glibc openssl; do
      echo "${pkg}: $(get_pkg_version ${pkg})"
    done
  } >"${dir}/MANIFEST"

  save_reusable cargo-reusable "$(get_pkg_variable rust PKG_REUSABLE_SOURCE_NAME)" "${dir}"
}
