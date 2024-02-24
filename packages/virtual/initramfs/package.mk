# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="initramfs"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_INIT="libc:init busybox:init plymouth-lite:init util-linux:init parted:init e2fsprogs:init dosfstools:init terminus-font:init"
PKG_DEPENDS_TARGET="toolchain initramfs:init"
PKG_SECTION="virtual"
PKG_LONGDESC="Metapackage for installing initramfs"

if [ "${ISCSI_SUPPORT}" = yes ]; then
  PKG_DEPENDS_INIT+=" open-iscsi:init"
fi

for i in ${PKG_DEPENDS_INIT}; do
  PKG_NEED_UNPACK+=" $(get_pkg_directory ${i})"
done
