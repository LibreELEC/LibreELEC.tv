# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet10-runtime"
PKG_VERSION="10.0.15"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="ea7a65aa1c33efd3375564ac03bae3c413e9817252adc89d11978fd8509520ea"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/10.0.15/aspnetcore-runtime-10.0.15-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="31ccebfbd023e536cbe6f6644ea85dbee8336a3b1b7e02752d17e59c0aedec58"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/10.0.15/aspnetcore-runtime-10.0.15-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="029d600b47d8e1676fbb652b8d1564bc76167bbbac5b8c3004a2bd3c33e55ee5"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/10.0.15/aspnetcore-runtime-10.0.15-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
