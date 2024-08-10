# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="polkit"
PKG_VERSION="126"
PKG_SHA256="2814a7281989f6baa9e57bd33bbc5e148827e2721ccef22aaf28ab2b376068e8"
PKG_LICENSE="GPL"
PKG_SITE="https://polkit.pages.freedesktop.org/polkit"
PKG_URL="https://github.com/polkit-org/polkit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat glib systemd"
PKG_LONGDESC="polkit provides an authorization API intended to be used by privileged programs offering service to unprivileged programs"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dauthfw=shadow \
                       -Dsession_tracking=logind \
                       -Dlibs-only=true \
                       -Dintrospection=false"
