# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet-runtime"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain icu aspnet8-runtime aspnet9-runtime"
PKG_SECTION="tools"
PKG_SHORTDESC="ASP.NET Core Runtime"
PKG_LONGDESC="ASP.NET Core Runtime ($(get_pkg_version aspnet8-runtime)) and ($(get_pkg_version aspnet9-runtime)) enables you to run existing console/web/server applications."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="ASP.Net Core Runtimes"
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    # aspnet8-runtime
    cp -r $(get_build_dir aspnet8-runtime)/* \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    # aspnet9-runtime
    cp -r $(get_build_dir aspnet9-runtime)/* \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

    # aspnet8-runtime
    cp -L $(get_install_dir icu)/usr/lib/lib*.so.?? \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shared/Microsoft.NETCore.App/$(get_pkg_version aspnet8-runtime)
    # aspnet9-runtime
    cp -L $(get_install_dir icu)/usr/lib/lib*.so.?? \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shared/Microsoft.NETCore.App/$(get_pkg_version aspnet9-runtime)

    # aspnet8-runtime
    sed -e "s/\"tfm\": \"net8.0\"/&,\n    \"configProperties\": {\n      \"System.Globalization.AppLocalIcu\": \"$(get_pkg_version icu | cut -f 1 -d .)\"\n    }/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shared/Microsoft.NETCore.App/$(get_pkg_version aspnet8-runtime)/Microsoft.NETCore.App.runtimeconfig.json
    # aspnet9-runtime
    sed -e "s/\"tfm\": \"net9.0\"/&,\n    \"configProperties\": {\n      \"System.Globalization.AppLocalIcu\": \"$(get_pkg_version icu | cut -f 1 -d .)\"\n    }/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shared/Microsoft.NETCore.App/$(get_pkg_version aspnet9-runtime)/Microsoft.NETCore.App.runtimeconfig.json
}
