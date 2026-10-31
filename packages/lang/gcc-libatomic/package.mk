# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-libatomic"
PKG_VERSION="$(get_pkg_version gcc)"
PKG_LICENSE="GPL-3.0-or-later"
PKG_ARCH="aarch64 x86_64"
PKG_URL=""
PKG_DEPENDS_HOST="toolchain:host gcc:host"
PKG_DEPENDS_TARGET="toolchain gcc-libatomic:host"
PKG_LONGDESC="This package provides the libatomic shared library of the GNU Compiler Collection."
PKG_DEPENDS_UNPACK+=" gcc"
PKG_PATCH_DIRS+=" $(get_pkg_directory gcc)/patches"

OPTS_LIBATOMIC="--enable-libatomic"
OPTS_STATIC="--disable-static"

# >>>>> This comes from the gcc package

if [ "${MOLD_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_HOST+=" mold:host"
fi

GCC_COMMON_CONFIGURE_OPTS="--target=${TARGET_NAME} \
                           --with-sysroot=${SYSROOT_PREFIX} \
                           --with-gmp=${TOOLCHAIN} \
                           --with-mpfr=${TOOLCHAIN} \
                           --with-mpc=${TOOLCHAIN} \
                           --with-zstd=${TOOLCHAIN} \
                           --with-gnu-as \
                           --with-gnu-ld \
                           --enable-plugin \
                           --enable-lto \
                           --enable-gold \
                           --enable-ld=default \
                           --with-linker-hash-style=gnu \
                           --disable-multilib \
                           --disable-nls \
                           --enable-checking=release \
                           --without-ppl \
                           --without-cloog \
                           --disable-libada \
                           --disable-libmudflap \
                           --disable-libitm \
                           --disable-libquadmath \
                           --disable-libgomp \
                           --disable-libmpx \
                           --disable-libssp \
                           --enable-__cxa_atexit"

PKG_CONFIGURE_OPTS_HOST="${GCC_COMMON_CONFIGURE_OPTS} \
                         --enable-languages=c,c++ \
                         ${OPTS_LIBATOMIC} \
                         --enable-decimal-float \
                         --enable-tls \
                         --enable-shared \
                         ${OPTS_STATIC} \
                         --enable-long-long \
                         --enable-threads=posix \
                         --disable-libstdcxx-pch \
                         --enable-libstdcxx-time \
                         --enable-clocale=gnu \
                         ${TARGET_ARCH_GCC_OPTS}"

# <<<<< This comes from the gcc package

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/gcc/gcc-${PKG_VERSION}.tar.xz -C ${PKG_BUILD}
}

pre_configure_host() {
  unset CPP
}

make_host() {
  make all-target-libatomic
}

makeinstall_host() {
  :
}

configure_target() {
  : # reuse configure_host()
}

make_target() {
  : # reuse make_host()
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
    cp -L ${PKG_BUILD}/.${HOST_NAME}/${TARGET_NAME}/libatomic/.libs/libatomic.so.[0-9] ${INSTALL}/usr/lib
}
