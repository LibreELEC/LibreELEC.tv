# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="podman"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://podman.io"
PKG_DEPENDS_TARGET="conmon gpgme podman-bin libseccomp netavark runc"
PKG_SECTION="service/system"
PKG_LONGDESC="Podman is a daemonless container engine for developing, managing, and running OCI Containers."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Podman"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private}

    # conmon
    cp -P $(get_install_dir conmon)/usr/lib/podman/conmon ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

    # gpgme
    cp -L $(get_install_dir gpgme)/usr/lib/libgpgme.so.45 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

    # libseccomp
    cp -L $(get_install_dir libseccomp)/usr/lib/libseccomp.so.2 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

    # netavark
    cp -P $(get_install_dir netavark)/netavark ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

    # podman
    cp -P $(get_build_dir podman-bin)/bin/podman ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    patchelf --add-rpath '$ORIGIN/../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/podman
    cp -P $(get_build_dir podman-bin)/bin/podman-remote ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/podman-remote

    # runc
    cp -P $(get_build_dir runc)/bin/runc ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/runc
}

post_install_addon() {
  :
}
