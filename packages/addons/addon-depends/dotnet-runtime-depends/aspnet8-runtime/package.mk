# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.34"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="c73f0f697cad06688ad38c6edc892112bd4f7e7049b2c084610f36a73e8cb0df"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.34/aspnetcore-runtime-8.0.34-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="1e1b483b34f1bf67dc560454e187a9c55a69ca66da2eb64337d271fc0343b122"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.34/aspnetcore-runtime-8.0.34-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="bc67c9341b4df0b4d3e3f0d71682e09af226afe61a4fa316d8b2a7a7eb44fe4f"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.34/aspnetcore-runtime-8.0.34-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
