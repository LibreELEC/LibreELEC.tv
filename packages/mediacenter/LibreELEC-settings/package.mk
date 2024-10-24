# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="LibreELEC-settings"
PKG_VERSION="6481489178160ad8db108c225fe150afb06379dc"
PKG_SHA256="a03a7a71368bf55957b88ae7eac3b633b2d497daab60d5e51b9f331f149f6fe1"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL="https://github.com/LibreELEC/service.libreelec.settings/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 connman dbussy"
PKG_LONGDESC="LibreELEC-settings: is a settings dialog for LibreELEC"

PKG_MAKE_OPTS_TARGET="ADDON_VERSION=${OS_VERSION} \
                      DISTRONAME=${DISTRONAME} \
                      ROOT_PASSWORD=${ROOT_PASSWORD}"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" setxkbmap"
else
  PKG_DEPENDS_TARGET+=" bkeymaps"
fi

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libreelec
    cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/lib/libreelec
    sed -e "s/@DISTRONAME@/${DISTRONAME}/g" \
      -i ${INSTALL}/usr/lib/libreelec/backup-restore
    sed -e "s/@DISTRONAME@/${DISTRONAME}/g" \
      -i ${INSTALL}/usr/lib/libreelec/factory-reset

  ADDON_INSTALL_DIR=${INSTALL}/usr/share/kodi/addons/service.libreelec.settings
  python_compile ${ADDON_INSTALL_DIR}/resources/lib/
}

post_install() {
  enable_service backup-restore.service
  enable_service factory-reset.service
}
