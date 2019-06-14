# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lvm2"
PKG_VERSION="2.03.16"
PKG_SHA256="e661ece15b5d88d8abe39a4c1e1db2f43e1896f019948bb98b0e15d777680786"
PKG_ARCH="any"
PKG_LICENSE="GPLv2 LGPL2.1"
PKG_SITE="https://sourceware.org/lvm2"
PKG_URL="http://mirrors.kernel.org/sourceware/lvm2/releases/LVM2.$PKG_VERSION.tgz"
PKG_SOURCE_DIR="LVM2.$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain systemd readline util-linux libaio"
PKG_SECTION="sysutils"
PKG_SHORTDESC="Logical Volume Manager 2 utilities"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_BUILD_FLAGS="-gold"

LVM2_CONFIG_DEFAULT="ac_cv_func_malloc_0_nonnull=yes \
                     ac_cv_func_realloc_0_nonnull=yes \
                     --disable-use-lvmlockd \
                     --disable-selinux \
                     --disable-dbus-service \
                     --with-cache=none \
                     --with-thin=none \
                     --with-clvmd=none \
                     --with-cluster=none"

PKG_CONFIGURE_OPTS_TARGET="$LVM2_CONFIG_DEFAULT \
                           --enable-pkgconfig \
                           --disable-applib \
                           --disable-cmdlib \
                           --enable-udev_sync \
                           --enable-udev_rules \
                           --enable-udev-rule-exec-detection \
                           --enable-lvmetad \
                           --enable-lvmpolld \
                           --disable-dmeventd \
                           --enable-dmfilemapd \
                           --enable-blkdeactivate \
                           --enable-write_install \
                           --with-default-system-dir=/storage/.config/lvm \
                           --with-confdir=/storage/.config \
                           --sysconfdir=/storage/.config \
                           --with-udevdir=/usr/lib/udev/rules.d \
                           --with-systemdsystemunitdir=/usr/lib/systemd/system \
                           --with-tmpfilesdir=/usr/lib/tmpfiles.d"


# fix modprobe in config.status
post_configure_target() {
  sed -i -E 's|/.*bin/modprobe|/usr/sbin/modprobe|g' ${PKG_REAL_BUILD}/config.status ${PKG_REAL_BUILD}/include/configure.h
}

post_makeinstall_target() {
  # more install targets
  make install_system_dirs DESTDIR=$INSTALL
  # make install_initscripts DESTDIR=$INSTALL
  make install_systemd_units DESTDIR=$INSTALL
  make install_systemd_generators DESTDIR=$INSTALL
  make install_tmpfiles_configuration DESTDIR=$INSTALL

  # detele cache dir
  rm -rf $INSTALL/storage/.config/lvm/cache

  # moving config to the right place
  mkdir -p $INSTALL/usr/config
  mv $INSTALL/storage/.config/lvm $INSTALL/usr/config
  rmdir $INSTALL/storage/.config $INSTALL/storage

  # fix config
  sed -i -e 's|cache_dir = "/etc/lvm/cache"|cache_dir = "/run/lvm"|g' $INSTALL/usr/config/lvm/lvm.conf
  sed -i -e 's|cache_dir = "/storage/.config/lvm/cache"|cache_dir = "/run/lvm"|g' $INSTALL/usr/config/lvm/lvm.conf
  pushd $INSTALL/usr/config/lvm
  for i in `ls -1 lvm*.conf profile/*.profile`; do
    sed -i -e 's|\([" ]\)/etc/lvm\([/ ]\)|\1/storage/.config/lvm\2|g' $i
  done
  popd

  # symlink for config
  mkdir -p $INSTALL/etc
  ln -s /storage/.config/lvm $INSTALL/etc/lvm

  # fix rebuild problem
  chmod u+w $INSTALL/usr/lib/libdevmapper.so*
}
