# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet5-runtime"
PKG_VERSION="5.0.7"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=".NET Runtime runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="375956c3d326f5030a1eff2cafdba8b994ed0e1b87db2dd812ce17e0bca5fb27"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/a9a37d9f-6158-43a4-a610-f0f9e8c2cb73/c69c6d22c668cb09b2d00bea8209335b/dotnet-runtime-5.0.7-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="fcc811f37cb6914bf3aa1c96040b1a46fad42939e6b1e1e7e0f513a9be1de680"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/09a24e9f-0096-454a-b761-70cdf9504775/eafe9578bbedd15c9319b7580d5a20d9/dotnet-runtime-5.0.7-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="ed864299f0e736f9d284b655e62d8a29aee97c14741ef8baf13d5ff493f83a47"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f229fc63-747e-46c8-89ac-88563c2e0b7d/8e59115deda958a26e1546f603cbad9a/dotnet-runtime-5.0.7-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="dotnet-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
