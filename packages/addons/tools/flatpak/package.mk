# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flatpak"
PKG_VERSION="1.19.0"
PKG_REV="18"
PKG_ARCH="aarch64 x86_64"
PKG_SHA256="5edc32467ce413205b61125a8323b680d1e5a9d560185bb7a154e6235a896b69"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://flatpak.org/"
PKG_URL="https://github.com/flatpak/flatpak/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain appstream bubblewrap fuse3 gdk-pixbuf gpgme json-glib libarchive ostree pyparsing:host systemd xdg-dbus-proxy zstd"
PKG_DEPENDS_CONFIG="appstream libassuan gpgme ostree shared-mime-info"
PKG_SECTION="tools"
PKG_SHORTDESC="Linux application sandboxing and distribution framework"
PKG_LONGDESC="Linux application sandboxing and distribution framework"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Flatpak"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"
PKG_ADDON_REQUIRES="tools.gnupg:0.0.0 tools.externalhelper:0.0.0"

PKG_LE_PATH="/storage/.kodi/addons/tools.flatpak"

PKG_MESON_OPTS_TARGET="--prefix=${PKG_LE_PATH} \
                       --bindir=${PKG_LE_PATH}/bin \
                       --libdir=${PKG_LE_PATH}/lib.private \
                       --libexecdir=${PKG_LE_PATH}/bin \
                       -Ddconf=disabled \
                       -Ddocbook_docs=disabled \
                       -Dgir=disabled \
                       -Dgtkdoc=disabled \
                       -Dlibzstd=enabled \
                       -Dmalcontent=disabled \
                       -Dman=disabled \
                       -Drun_media_dir=/media \
                       -Dseccomp=disabled \
                       -Dselinux_module=disabled \
                       -Dsystem_bubblewrap=${PKG_LE_PATH}/bin/bwrap \
                       -Dsystem_dbus_proxy=${PKG_LE_PATH}/bin/xdg-dbus-proxy \
                       -Dsystem_bubblewrap=${PKG_LE_PATH}/bin/bwrap \
                       -Dsystem_fusermount=${PKG_LE_PATH}/bin/fusermount3 \
                       -Dsystem_install_dir=/storage/flatpak \
                       -Dsystem_helper=disabled \
                       -Dsystemd=enabled \
                       -Dtests=false \
                       -Dxauth=disabled \
                       -Dwayland_security_context=disabled"

pre_configure_target() {
  export TARGET_CFLAGS+=" -I$(get_install_dir gpgme)/usr/include"
  export TARGET_LDFLAGS+=" -L$(get_install_dir gpgme)/usr/lib -lcrypto -lbz2 -lz -llz4 -llzo2"
}

addon() {
  local src="${PKG_INSTALL}${PKG_LE_PATH}"
  local dest="${ADDON_BUILD}/${PKG_ADDON_ID}"

  mkdir -p ${dest}/bin
    cp ${src}/bin/{flatpak,flatpak-portal,flatpak-session-helper} ${dest}/bin
    cp $(get_install_dir bubblewrap)/usr/bin/bwrap ${dest}/bin
    cp $(get_install_dir fuse3)/usr/bin/fusermount3 ${dest}/bin
    cp $(get_install_dir xdg-dbus-proxy)/usr/bin/xdg-dbus-proxy ${dest}/bin

    for f in bwrap flatpak flatpak-portal flatpak-session-helper fusermount3 xdg-dbus-proxy; do
      patchelf --add-rpath '${ORIGIN}/../lib.private' ${dest}/bin/$f
    done

  mkdir -p ${dest}/lib.private
    cp -L $(get_install_dir appstream)/usr/lib/libappstream.so.5 ${dest}/lib.private
    cp -L $(get_install_dir gpgme)/usr/lib/libgpgme.so.45 ${dest}/lib.private
    cp -L $(get_install_dir json-glib)/usr/lib/libjson-glib-1.0.so.0 ${dest}/lib.private
    cp -L $(get_install_dir ostree)/usr/lib/libostree-1.so.1 ${dest}/lib.private

  mkdir -p ${dest}/services
    cp ${src}/lib/systemd/user/{flatpak-portal.service,flatpak-session-helper.service} ${dest}/services
    cp ${src}/share/dbus-1/services/{org.freedesktop.Flatpak.service,org.freedesktop.portal.Flatpak.service} ${dest}/services
}
