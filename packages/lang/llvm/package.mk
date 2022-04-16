# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="llvm"
PKG_VERSION="14.0.1"
PKG_SHA256="5b89017dec2729311ab143402f03da1dea6d0c79dd5c701bc939cf8b34f01ec2"
PKG_ARCH="x86_64"
PKG_LICENSE="Apache-2.0"
PKG_SITE="http://llvm.org/"
PKG_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-${PKG_VERSION}/llvm-${PKG_VERSION}.src.tar.xz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain llvm:host zlib"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure."

PKG_CMAKE_OPTS_COMMON="-DLLVM_INCLUDE_TOOLS=ON \
                       -DLLVM_BUILD_TOOLS=OFF \
                       -DLLVM_BUILD_UTILS=OFF \
                       -DLLVM_BUILD_EXAMPLES=OFF \
                       -DLLVM_INCLUDE_EXAMPLES=OFF \
                       -DLLVM_BUILD_TESTS=OFF \
                       -DLLVM_INCLUDE_TESTS=OFF \
                       -DLLVM_INCLUDE_GO_TESTS=OFF \
                       -DLLVM_BUILD_BENCHMARKS=OFF \
                       -DLLVM_INCLUDE_BENCHMARKS=OFF \
                       -DLLVM_BUILD_DOCS=OFF \
                       -DLLVM_INCLUDE_DOCS=OFF \
                       -DLLVM_ENABLE_DOXYGEN=OFF \
                       -DLLVM_ENABLE_SPHINX=OFF \
                       -DLLVM_ENABLE_OCAMLDOC=OFF \
                       -DLLVM_ENABLE_BINDINGS=OFF \
                       -DLLVM_TARGETS_TO_BUILD=AMDGPU \
                       -DLLVM_ENABLE_TERMINFO=OFF \
                       -DLLVM_ENABLE_ASSERTIONS=OFF \
                       -DLLVM_ENABLE_WERROR=OFF \
                       -DLLVM_ENABLE_ZLIB=ON \
                       -DLLVM_ENABLE_LIBXML2=OFF \
                       -DBUILD_SHARED_LIBS=ON \
                       -DLLVM_OPTIMIZED_TABLEGEN=ON \
                       -DLLVM_APPEND_VC_REV=OFF \
                       -DLLVM_ENABLE_RTTI=ON \
                       -DLLVM_ENABLE_UNWIND_TABLES=OFF \
                       -DLLVM_ENABLE_Z3_SOLVER=OFF"

post_unpack() {
  # the cmake/Modules/*.cmake are appended to the tar archive file.
  # move these into llvm-pkgver/cmake/modules directory.
  mv -n ${PKG_BUILD}/Modules/*.cmake ${PKG_BUILD}/cmake/modules/
}

pre_configure_host() {
  CXXFLAGS+=" -DLLVM_CONFIG_EXEC_PREFIX=\\\"${SYSROOT_PREFIX}/usr\\\""
  PKG_CMAKE_OPTS_HOST="${PKG_CMAKE_OPTS_COMMON}"
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_COMMON} \
                         -DLLVM_TARGET_ARCH="${TARGET_ARCH}" \
                         -DLLVM_TABLEGEN=${TOOLCHAIN}/bin/llvm-tblgen"
}

make_host() {
  ninja ${NINJA_OPTS} llvm-config llvm-tblgen
}

makeinstall_host() {
  cp -a lib/libLLVM*.so ${TOOLCHAIN}/lib
  cp -a lib/libLLVM*.so.14 ${TOOLCHAIN}/lib
  cp -a bin/llvm-config ${TOOLCHAIN}/bin/llvm-config-host
  cp -a bin/llvm-tblgen ${TOOLCHAIN}/bin
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/lib/LLVMHello.so
  rm -rf ${INSTALL}/usr/lib/libLTO.so
  rm -rf ${INSTALL}/usr/share
}
