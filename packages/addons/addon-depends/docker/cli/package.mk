# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cli"
PKG_VERSION="$(get_pkg_version moby)"
PKG_SHA256="ea7ed901729d93f753226b2e374cddeffed86d56d13cbfa23920b810f33a01e9"
PKG_LICENSE="ASL"
PKG_SITE="https://github.com/docker/cli"
PKG_URL="https://github.com/docker/cli/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="The Docker CLI"
PKG_TOOLCHAIN="manual"

# Git commit of the matching tag https://github.com/docker/cli/tags
export PKG_GIT_COMMIT="eedd9698e9c3ee3aa9100789ea4b4515443d2e50"

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
