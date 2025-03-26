# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)

PKG_NAME="jdk-arm-zulu"
PKG_VERSION="8.84.0.15-8.0.442"
PKG_SHA256="3a164013eae14af23256b7fbaedc6ac3abc295f3bfafd794e5f5a44266ddecab"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-embedded/"
PKG_URL="https://cdn.azul.com/zulu-embedded/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_aarch32hf.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip

  # libbluray needs arm/server
  mv ${PKG_BUILD}/jre/lib/aarch32    ${PKG_BUILD}/jre/lib/arm
  mv ${PKG_BUILD}/jre/lib/arm/client ${PKG_BUILD}/jre/lib/arm/server
}
