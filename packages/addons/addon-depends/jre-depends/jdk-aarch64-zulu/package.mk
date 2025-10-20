# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)

PKG_NAME="jdk-aarch64-zulu"
PKG_VERSION="8.88.0.19-8.0.462"
PKG_SHA256="7f3a4f6a24f764259db98c69e759bf7cae95ce957dadd74117ed5d6037fcfcc7"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-embedded/"
PKG_URL="http://cdn.azul.com/zulu/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_aarch64.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip

  # libbluray needs arm
  mv ${PKG_BUILD}/jre/lib/aarch64 ${PKG_BUILD}/jre/lib/arm
}
