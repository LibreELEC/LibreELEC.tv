# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fontconfig"
PKG_VERSION="2.18.4"
PKG_SHA256="95013637eff5f81d4871dd16cd098c273264c16d0f9f0b27cc43b81b2794bee3"
PKG_LICENSE="HPND-sell-variant"
PKG_SITE="https://www.freedesktop.org/wiki/Software/fontconfig/"
PKG_URL="https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-linux util-macros freetype libxml2 zlib expat"
PKG_LONGDESC="Fontconfig is a library for font customization and configuration."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--with-arch=${TARGET_ARCH} \
                           ac_cv_va_copy=C99 \
                           fc_cv_c99_vsnprintf=yes \
                           ac_cv_have_working_snprintf=yes \
                           ac_cv_have_working_vsnprintf=yes \
                           --with-cache-dir=/storage/.cache/fontconfig \
                           --with-default-fonts=/usr/share/fonts \
                           --without-add-fonts \
                           --disable-dependency-tracking \
                           --disable-docs \
                           --disable-rpath"

pre_configure_target() {
  # ensure we dont use '-O3' optimization.
  CFLAGS=$(echo ${CFLAGS} | sed -e "s|-O3|-O2|")
  CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-O3|-O2|")
  CFLAGS+=" -I${PKG_BUILD}"
  CXXFLAGS+=" -I${PKG_BUILD}"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
