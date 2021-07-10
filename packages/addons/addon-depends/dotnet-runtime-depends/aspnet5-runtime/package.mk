# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet5-runtime"
PKG_VERSION="5.0.7"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="219f233d4e23e2381d93dc99a7cbdbe55c55e45da2e025b5d139d1338d11d62a"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/d0a22fa3-b916-49ce-8284-97131b424cb3/cb884163ad34b83f1ae1dbd33e09d77a/aspnetcore-runtime-5.0.7-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="c14e64527f2bf7356d1de154132a07b86de4a30c62129e138f3ca95a43c2dd54"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/2f690848-1342-4768-a7d7-45fa476a4a22/50dd1c50ed7864140b04fec057bb8bd6/aspnetcore-runtime-5.0.7-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="22f9f93b4d6a00e76980918b721f7f62654421d7582d486e830ec478c365707c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/d6be94b3-458f-43c4-8bb5-9ba261de8c9c/bbe13b54208d088b5fdf428759b5bc0a/aspnetcore-runtime-5.0.7-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
