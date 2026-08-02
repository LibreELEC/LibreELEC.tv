# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wsdd-native"
PKG_VERSION="1.27"
PKG_SHA256="be374039ca4650cc8207c0655064b18d5cd640acee7d8376bde37944b73ab8ff"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/gershnik/wsdd-native"
PKG_URL="https://github.com/gershnik/wsdd-native/releases/download/v${PKG_VERSION}/wsddn-src-prefetch-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libfmt libxml2 spdlog systemd"
PKG_DEPENDS_UNPACK="asio"
PKG_LONGDESC="WS-Discovery host daemon, making the machine visible to Windows Explorer."
PKG_BUILD_FLAGS="+size"

# Use prefetch dependency if not a LibreELEC package - use the system
# copies of the libraries we already ship. FETCHCONTENT_FULLY_DISCONNECTED
# makes a missing dependency fail loudly instead of silently downloading
# it at build time.
PKG_CMAKE_OPTS_TARGET="-DWSDDN_PREFER_SYSTEM_LIBXML2=ON \
                       -DWSDDN_PREFER_SYSTEM_FMT=ON \
                       -DWSDDN_PREFER_SYSTEM_SPDLOG=ON \
                       -DWSDDN_NO_TARGET_PATHS_DETECTION=ON \
                       -DHAVE_SYSTEMD=ON \
                       -DLIBSYSTEMD_SO=libsystemd.so.0 \
                       -DCMAKE_INSTALL_BINDIR=sbin \
                       -DFETCHCONTENT_FULLY_DISCONNECTED=ON \
                       -DFETCHCONTENT_SOURCE_DIR_ARGUM=../external/argum \
                       -DFETCHCONTENT_SOURCE_DIR_ASIO=$(get_build_dir asio)/asio \
                       -DFETCHCONTENT_SOURCE_DIR_ISPTR=../external/isptr \
                       -DFETCHCONTENT_SOURCE_DIR_MODERN-UUID=../external/modern-uuid \
                       -DFETCHCONTENT_SOURCE_DIR_OUTCOME=../external/outcome \
                       -DFETCHCONTENT_SOURCE_DIR_PTL=../external/ptl \
                       -DFETCHCONTENT_SOURCE_DIR_SYS_STRING=../external/sys_string \
                       -DFETCHCONTENT_SOURCE_DIR_TOMLPLUSPLUS=../external/tomlplusplus"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp ${PKG_DIR}/system.d/*.service ${INSTALL}/usr/lib/systemd/system
}

post_install() {
  enable_service wsddn.service
}
