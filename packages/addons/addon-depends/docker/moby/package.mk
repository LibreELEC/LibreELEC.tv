# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="moby"
PKG_VERSION="29.9.3"
PKG_SHA256="cd6ce54e46ac19f5dd0b5226a9b292965ba542bc16bdf9edbbca946da8930b15"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://mobyproject.org/"
PKG_URL="https://github.com/moby/moby/archive/docker-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host nftables systemd"
PKG_LONGDESC="Moby is an open-source project created by Docker to enable and accelerate software containerization."
PKG_TOOLCHAIN="manual"
PKG_NO_REFRESH_PATCHES="tools/moby/gen-patches.sh"

# Git commit of the matching release https://github.com/moby/moby
export PKG_GIT_COMMIT="70efc0e31da3a115fc87574d1b786fa2b867c346"

PKG_MOBY_BUILDTAGS="daemon \
                    autogen \
                    exclude_graphdriver_devicemapper \
                    exclude_graphdriver_aufs \
                    exclude_graphdriver_btrfs \
                    exclude_graphdriver_zfs \
                    journald"

configure_target() {
  go_configure

  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld ${CC}"

  # used for docker version
  export GITCOMMIT=${PKG_GIT_COMMIT}
  export VERSION=${PKG_VERSION}
  export BUILDTIME="$(date --utc)"

  GO111MODULE=auto ${GOLANG} mod tidy -modfile 'go.mod' -compat 1.24.3
  GO111MODULE=auto ${GOLANG} mod vendor -modfile go.mod

  source hack/make/.go-autogen
}

make_target() {
  mkdir -p bin
  ${GOLANG} build -mod=mod -modfile=go.mod -v -o bin/docker-proxy -a -ldflags "${LDFLAGS}" ./cmd/docker-proxy
  ${GOLANG} build -mod=mod -modfile=go.mod -v -o bin/dockerd -a -tags "${PKG_MOBY_BUILDTAGS}" -ldflags "${LDFLAGS}" ./cmd/dockerd

  # fix permissions of .gopath to allow clean during CI build
  chmod -R u+w .gopath
}

makeinstall_target() {
  :
}
