# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="go"
PKG_VERSION="1.27.4"
PKG_SHA256="89c2891539e2d372572836ede46d5073d54f356cba062cc0b39c1fffaf724a89"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://golang.org"
PKG_URL="https://github.com/golang/go/archive/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="An programming language that makes it easy to build simple, reliable, and efficient software."
PKG_TOOLCHAIN="manual"

configure_host() {
  export GOROOT_FINAL=${TOOLCHAIN}/lib/golang
  if [ -x /usr/local/go/bin/go ]; then
    export GOROOT_BOOTSTRAP=/usr/local/go
  elif [ -x /usr/lib/go/bin/go ]; then
    export GOROOT_BOOTSTRAP=/usr/lib/go
  else
    export GOROOT_BOOTSTRAP=/usr/lib/golang
  fi

  if [ ! -d ${GOROOT_BOOTSTRAP} ]; then
    cat <<EOF
####################################################################
# On Fedora 'dnf install golang' will install go to /usr/lib/golang
#
# On Ubuntu you need to install golang:
# $ sudo apt install golang-go
####################################################################
EOF
    return 1
  fi
}

make_host() {
  cd ${PKG_BUILD}/src
  bash make.bash --no-banner
}

pre_makeinstall_host() {
  # need to cleanup old golang version when updating to a new version
  rm -rf ${TOOLCHAIN}/lib/golang
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/golang
  cp -av ${PKG_BUILD}/* ${TOOLCHAIN}/lib/golang/
}
