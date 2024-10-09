# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.18"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="74b20f12c7e48f47d90e150a646f05bf1b6db34659f28d34ac25fa7be35dd66f"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.18/aspnetcore-runtime-8.0.18-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="28899322ab8af69708202f7797abe747a17566da84e6fd3747a49af95cc19bff"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.18/aspnetcore-runtime-8.0.18-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="3902cd2a0742e6f59b72e031bc46a6f39cdf070ec2ee20174ebd373dd496a652"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.18/aspnetcore-runtime-8.0.18-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
