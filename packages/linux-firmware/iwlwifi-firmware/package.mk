# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="iwlwifi-firmware"
PKG_VERSION="bc351346a48512ebc0709b373a661919e2a6087b"
PKG_SHA256="e5138993c5e61b3665fc37c241452f2b42d1e27209a74e63a4e7a07b16190209"
PKG_LICENSE="LicenseRef-Free-to-use"
PKG_SITE="https://github.com/LibreELEC/iwlwifi-firmware"
PKG_URL="https://github.com/LibreELEC/iwlwifi-firmware/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="iwlwifi-firmware: firmwares for various Intel WLAN drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir) ./install
}
