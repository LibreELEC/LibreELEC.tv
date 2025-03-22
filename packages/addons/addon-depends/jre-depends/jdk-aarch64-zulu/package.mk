# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)

PKG_NAME="jdk-aarch64-zulu"
PKG_VERSION="8.84.0.15-8.0.442"
PKG_SHA256="3ae6b27727a308c0c262a99e20af29c87aad7910de423db2607c44551b598e57"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-embedded/"
PKG_URL="http://cdn.azul.com/zulu/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_aarch64.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip
}
