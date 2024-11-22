# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="talloc"
PKG_VERSION="2.4.2"
PKG_SHA256="85ecf9e465e20f98f9950a52e9a411e14320bc555fa257d87697b7e7a9b1d8a6"
PKG_LICENSE="LGPL-3.0-or-later"
PKG_SITE="https://talloc.samba.org/"
PKG_URL="https://www.samba.org/ftp/talloc/talloc-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="talloc is a hierarchical, reference counted memory pool system with destructors"

configure_package() {
  PKG_WAF_VERBOSE="-v"

  PKG_CONFIGURE_OPTS="--prefix=/usr \
                      --bindir=/usr/bin \
                      --sbindir=/usr/sbin \
                      --sysconfdir=/etc \
                      --libdir=/usr/lib \
                      --libexecdir=/usr/lib \
                      --localstatedir=/var \
                      --cross-compile \
                      --cross-answers=${PKG_BUILD}/cache.txt \
                      --hostcc=gcc \
                      --disable-rpath \
                      --disable-rpath-install \
                      --disable-rpath-private-install"
}

pre_configure_target() {
  # talloc uses its own build directory
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}

  # support 64-bit offsets and seeks on 32-bit platforms
  if [ "${TARGET_ARCH}" = "arm" ]; then
    export CFLAGS+=" -D_FILE_OFFSET_BITS=64 -D_OFF_T_DEFINED_ -Doff_t=off64_t -Dlseek=lseek64"
  fi
}

configure_target() {
  cp ${PKG_DIR}/config/talloc-cache.txt ${PKG_BUILD}/cache.txt
    echo "Checking uname machine type: \"${TARGET_ARCH}\"" >>${PKG_BUILD}/cache.txt

  PYTHON_CONFIG="${SYSROOT_PREFIX}/usr/bin/python3-config" \
  python_LDFLAGS="" python_LIBDIR="" \
  PYTHON=${TOOLCHAIN}/bin/python3 ./configure ${PKG_CONFIGURE_OPTS}
}

make_target() {
  make ${PKG_SAMBA_TARGET} -j${CONCURRENCY_MAKE_LEVEL}
}

makeinstall_target() {
  PYTHONHASHSEED=1 WAF_MAKE=1 ./buildtools/bin/waf install ${PKG_WAF_VERBOSE} --destdir=${SYSROOT_PREFIX} -j${CONCURRENCY_MAKE_LEVEL}
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/bin/default/libtalloc.so* ${INSTALL}/usr/lib
}
