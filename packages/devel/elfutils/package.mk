# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="elfutils"
PKG_VERSION="0.193"
PKG_SHA256="7857f44b624f4d8d421df851aaae7b1402cfe6bcdd2d8049f15fc07d3dde7635"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceware.org/elfutils/"
PKG_URL="https://sourceware.org/elfutils/ftp/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="autoconf:host automake:host m4:host make:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib elfutils:host libarchive"
PKG_LONGDESC="A collection of utilities to handle ELF objects."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic -cfg-libs -cfg-libs:host"

if [ "${DISTRO_VERSION}" = "devel" ]; then
  PKG_PROGRAMS="--enable-programs --program-prefix="
  PKG_PROGRAMS_LIST="readelf"
else
  PKG_PROGRAMS="--disable-programs"
  PKG_PROGRAMS_LIST=
fi

PKG_CONFIGURE_OPTS_HOST="utrace_cv_cc_biarch=false \
                         --disable-programs \
                         --disable-nls \
                         --disable-debuginfod \
                         --disable-libdebuginfod \
                         --with-zlib \
                         --without-bzlib \
                         --without-lzma"

PKG_CONFIGURE_OPTS_TARGET="utrace_cv_cc_biarch=false \
                           ${PKG_PROGRAMS} \
                           --disable-nls \
                           --disable-debuginfod \
                           --disable-libdebuginfod \
                           --with-zlib \
                           --without-bzlib \
                           --without-lzma"

pre_configure_target() {
  export PKG_CONFIG="${PKG_CONFIG} --static"
}

post_makeinstall_target() {
  # don't install progs into sysroot
  rm -fr ${SYSROOT_PREFIX}/usr/bin

  if [ -n "${PKG_PROGRAMS_LIST}" ]; then
    for PKG_TEMP in $(find ${INSTALL}/usr/bin -type f); do
      listcontains "${PKG_PROGRAMS_LIST}" ${PKG_TEMP#${INSTALL}/usr/bin/} || rm ${PKG_TEMP}
    done
  fi
}
