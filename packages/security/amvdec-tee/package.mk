# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="amvdec-tee"
PKG_VERSION="b9b865669d5ef7e3d758040dcb3ace38c9a9aed9"
PKG_SHA256="7a65cd93fa930e5eeb6017a078a226ca52c9f28bc6fe573746dd9abd83089926"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/LibreELEC/amvdec-tee"
PKG_URL="https://github.com/LibreELEC/amvdec-tee/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain optee_client"
PKG_LONGDESC="Secure World (TEE) AMRISC firmware pre-load service"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  make DESTDIR=${INSTALL} install
}

post_install() {
  enable_service amvdec-tee.service
}
