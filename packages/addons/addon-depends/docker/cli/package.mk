# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cli"
PKG_VERSION="$(get_pkg_version moby)"
PKG_SHA256="64701a1a4a2d3906f43809cd7b8636246e73432715d1fb279c35b18bca0e4b76"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/docker/cli"
PKG_URL="https://github.com/docker/cli/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="The Docker CLI"
PKG_TOOLCHAIN="manual"

# Git commit of the matching tag https://github.com/docker/cli/tags
export PKG_GIT_COMMIT="c48360f51c53d2029ab6721ad4d012f9e14df846"

configure_target() {
  go_configure

  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld ${CC}"

  # used for docker version
  export GITCOMMIT=${PKG_GIT_COMMIT}
  export VERSION=${PKG_VERSION}
  export BUILDTIME="$(date --utc)"

  cat >"${PKG_BUILD}/go.mod" <<EOF
module github.com/docker/cli

go 1.18
EOF

  GO111MODULE=auto ${GOLANG} mod tidy -modfile 'vendor.mod' -compat 1.18
  GO111MODULE=auto ${GOLANG} mod vendor -modfile vendor.mod
}

make_target() {
  mkdir -p bin
  PKG_CLI_FLAGS="-X 'github.com/docker/cli/cli/version.Version=${VERSION}'"
  PKG_CLI_FLAGS+=" -X 'github.com/docker/cli/cli/version.GitCommit=${GITCOMMIT}'"
  PKG_CLI_FLAGS+=" -X 'github.com/docker/cli/cli/version.BuildTime=${BUILDTIME}'"
  ${GOLANG} build -mod=mod -modfile=vendor.mod -v -o bin/docker -a -tags "${PKG_DOCKER_BUILDTAGS}" -ldflags "${LDFLAGS} ${PKG_CLI_FLAGS}" ./cmd/docker
}

makeinstall_target() {
  :
}
