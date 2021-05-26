# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jdk-x86_64-zulu"
PKG_VERSION="11.45.27-11.0.10"
PKG_SHA256="0bd85593bae021314378f3b146cfe36a6c9b0afd964d897c34201034ace3e785"
PKG_LICENSE="GPLv2"
if [ ! "${HOSTTYPE}" = "${TARGET_ARCH}" ]; then
  PKG_DEPENDS_UNPACK="jdk-${HOSTTYPE}-zulu"
fi
PKG_SITE="https://www.azul.com/products/zulu-enterprise/"
PKG_URL="https://cdn.azul.com/zulu/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_x64.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip

  # Create a runtime image with all Java SE modules
  cd ${PKG_BUILD}
    bin/jlink --output jre11 --add-modules java.se
}
