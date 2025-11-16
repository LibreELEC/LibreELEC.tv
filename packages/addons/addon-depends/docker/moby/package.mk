# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="moby"
PKG_VERSION="29.0.1"
PKG_SHA256="1a95241adb3f648784b767352d87b16c3b1e8b2836e44685e2a5cc122619d9dd"
PKG_LICENSE="ASL"
PKG_SITE="https://mobyproject.org/"
PKG_URL="https://github.com/moby/moby/archive/docker-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host systemd"
PKG_LONGDESC="Moby is an open-source project created by Docker to enable and accelerate software containerization."
PKG_TOOLCHAIN="manual"

# Git commit of the matching release https://github.com/moby/moby
export PKG_GIT_COMMIT="198b5e3ed55aa0bcde02ef4502afa7549ad8d355"

PKG_MOBY_BUILDTAGS="daemon \
                    autogen \
                    exclude_graphdriver_devicemapper \
                    exclude_graphdriver_aufs \
                    exclude_graphdriver_btrfs \
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
}

makeinstall_target() {
  :
}
