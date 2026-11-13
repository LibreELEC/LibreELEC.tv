# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rust"
PKG_VERSION="1.100.0"
PKG_SHA256="e8904548563117043c24a67c4967119b7c9ed304821988283e7681122ceec98b"
PKG_LICENSE="MIT OR Apache-2.0"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/rustc-${PKG_VERSION}-src.tar.gz"
PKG_DEPENDS_HOST="toolchain llvm:host"
PKG_DEPENDS_UNPACK="rustc-snapshot rust-std-snapshot cargo-snapshot"
PKG_LONGDESC="A systems programming language that prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

# the prebuilt rust:host and cargo:host published by cargo-reusable, named after
# a hash of their recipes so that a stale archive is never used. llvm, gcc,
# glibc and openssl stay backwards compatible within a release.
if [ "${USE_REUSABLE}" = "yes" -o "${USE_REUSABLE}" = "preferred" ] ||
   listcontains "${BUILD_REUSABLE}" "(all|cargo:host)"; then
  PKG_REUSABLE_HASH="$(get_reusable_inputs_hash rust cargo)"
  PKG_REUSABLE_VERSION="${OS_VERSION}-${PKG_VERSION}"
  PKG_REUSABLE_SOURCE_NAME="cargo-reusable-${PKG_REUSABLE_VERSION}-${MACHINE_HARDWARE_NAME}-${TARGET_NAME}-${PKG_REUSABLE_HASH}.tar.xz"
  PKG_REUSABLE_URL="https://github.com/LibreELEC/cargo-reusable/releases/download/${PKG_REUSABLE_VERSION}/${PKG_REUSABLE_SOURCE_NAME}"
fi

# preferred falls back to building rust:host when no reusable archive is available
if [ "${USE_REUSABLE}" = "yes" ] ||
   { [ "${USE_REUSABLE}" = "preferred" ] &&
     [ -n "$(get_reusable_sha256 cargo-reusable ${PKG_REUSABLE_SOURCE_NAME} ${PKG_REUSABLE_URL})" ]; }; then
  # rust and cargo then only pull in the archive
  PKG_REUSABLE="yes"
  PKG_SECTION="virtual"
  PKG_URL=""
  PKG_SHA256=""
  PKG_DEPENDS_HOST="cargo-reusable:host"
  PKG_DEPENDS_UNPACK=""
  # scripts/build still unpacks a virtual package, and there is no source to patch
  PKG_SKIP_PATCHES="yes"
fi

pre_configure_host() {
  "$(get_build_dir rustc-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir rust-std-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir cargo-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
}

configure_host() {

  cat >${PKG_BUILD}/config.toml  <<END
change-id = 162423

[llvm]
download-ci-llvm = false

[target.${TARGET_NAME}]
llvm-config = "${TOOLCHAIN}/bin/llvm-config"
cxx = "${TARGET_PREFIX}g++"
cc = "${TARGET_PREFIX}gcc"

[target.${RUST_HOST}]
llvm-config = "${TOOLCHAIN}/bin/llvm-config"
cxx = "${CXX}"
cc = "${CC}"

[rust]
rpath = true
channel = "stable"
codegen-tests = false
optimize = true
download-rustc = false
deny-warnings = false

[build]
submodules = false
docs = false
profiler = true
vendor = true

rustc = "${PKG_BUILD}/rust-snapshot/bin/rustc"
cargo = "${PKG_BUILD}/rust-snapshot/bin/cargo"

target = [
  "${TARGET_NAME}",
  "${RUST_HOST}"
]

host = [
  "${RUST_HOST}"
]

build = "${RUST_HOST}"

[install]
prefix = "${TOOLCHAIN}"
bindir = "${TOOLCHAIN}/bin"
libdir = "${TOOLCHAIN}/lib"
datadir = "${TOOLCHAIN}/share"
mandir = "${TOOLCHAIN}/share/man"

END

  create_cargo_home
}

make_host() {
  cd ${PKG_BUILD}

  unset CFLAGS
  unset CXXFLAGS
  unset CPPFLAGS
  unset LDFLAGS

  export RUST_TARGET_PATH="${PKG_BUILD}/targets/"
  export HOST_CMAKE="${TOOLCHAIN}/bin/cmake"
  export HOST_CMAKE_TOOLCHAIN_FILE="${CMAKE_CONF}"

  python3 src/bootstrap/bootstrap.py -j ${CONCURRENCY_MAKE_LEVEL} build --stage 2 --verbose
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp -a build/${RUST_HOST}/stage2/bin/{rustc,rustdoc} ${TOOLCHAIN}/bin

  mkdir -p ${TOOLCHAIN}/lib/rustlib
    cp -a build/${RUST_HOST}/stage2/lib/* ${TOOLCHAIN}/lib
}
