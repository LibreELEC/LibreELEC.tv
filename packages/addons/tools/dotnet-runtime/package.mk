# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet-runtime"
PKG_REV="9"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain icu aspnet8-runtime aspnet10-runtime"
PKG_SECTION="tools"
PKG_SHORTDESC="ASP.NET Core Runtime"
PKG_LONGDESC="ASP.NET Core Runtime ($(get_pkg_version aspnet8-runtime)), and ($(get_pkg_version aspnet10-runtime)) enables you to run existing console/web/server applications."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="ASP.Net Core Runtimes"
PKG_ADDON_ICON_NAME="none"
PKG_ADDON_ICON_SIZE="280"
PKG_ADDON_ICON_OFFSET='0'
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  local runtime runtime_dir runtime_version netcore_dir
  local icu_major="$(get_pkg_version icu)"

  icu_major="${icu_major%%.*}"

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  # bundle every aspnet runtime listed in PKG_DEPENDS_TARGET
  for runtime in ${PKG_DEPENDS_TARGET}; do
    case "${runtime}" in
      aspnet*-runtime) ;;
      *) continue ;;
    esac

    runtime_dir="$(get_build_dir ${runtime})"
    runtime_version="$(get_pkg_version ${runtime})"
    [ -n "${runtime_dir}" -a -n "${runtime_version}" ] || die "${PKG_NAME}: unknown package ${runtime}"
    netcore_dir="${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shared/Microsoft.NETCore.App/${runtime_version}"

    cp -r "${runtime_dir}"/* ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -L $(get_install_dir icu)/usr/lib/lib*.so.?? "${netcore_dir}"

    sed -e "s/\"tfm\": \"net${runtime_version%%.*}.0\"/&,\n    \"configProperties\": {\n      \"System.Globalization.AppLocalIcu\": \"${icu_major}\"\n    }/" \
      -i "${netcore_dir}/Microsoft.NETCore.App.runtimeconfig.json"
  done
}
