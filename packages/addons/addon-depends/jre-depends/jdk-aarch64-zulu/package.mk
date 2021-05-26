# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jdk-aarch64-zulu"
PKG_VERSION="11.45.27-11.0.10"
PKG_SHA256="e5d211df9576040919eb22884189b59f50cd319877c8855e37714eff1b327d2b"
PKG_LICENSE="GPLv2"
if [ ! "${HOSTTYPE}" = "${TARGET_ARCH}" ]; then
  PKG_DEPENDS_UNPACK="jdk-${HOSTTYPE}-zulu"
fi
PKG_SITE="https://www.azul.com/products/zulu-embedded/"
PKG_URL="http://cdn.azul.com/zulu-embedded/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_aarch64.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip

  # Create a runtime image with all Java SE modules
  cd $(get_build_dir jdk-${HOSTTYPE}-zulu) # this is the buildhost.ARCH
    bin/jlink --module-path ${PKG_BUILD}/jmods --output ${PKG_BUILD}/jre11 --add-modules java.se
}
