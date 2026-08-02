# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wsdd-native"
PKG_VERSION="cd8b5be6ab369dc6f99ed0ca3414710e55463c02"
PKG_SHA256="fc57cba5f8dd612b0586a880c3f4104477ca13234806e4ce22ef042ee772dc67"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/gershnik/wsdd-native"
PKG_URL="https://github.com/gershnik/wsdd-native/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libfmt libxml2 spdlog systemd"
PKG_DEPENDS_UNPACK="argum asio isptr modern-uuid outcome ptl sys_string tomlplusplus"
PKG_LONGDESC="WS-Discovery host daemon, making the machine visible to Windows Explorer."
PKG_BUILD_FLAGS="+size"

# Every dependency is a LibreELEC package - use the system copies of the
# libraries we already ship, and feed FetchContent the unpacked sources of
# the remainder. FETCHCONTENT_FULLY_DISCONNECTED makes a missing dependency
# fail loudly instead of silently downloading it at build time.
PKG_CMAKE_OPTS_TARGET="-DWSDDN_PREFER_SYSTEM_LIBXML2=ON \
                       -DWSDDN_PREFER_SYSTEM_FMT=ON \
                       -DWSDDN_PREFER_SYSTEM_SPDLOG=ON \
                       -DHAVE_SYSTEMD=ON \
                       -DLIBSYSTEMD_SO=libsystemd.so.0 \
                       -DCMAKE_INSTALL_BINDIR=sbin \
                       -DFETCHCONTENT_FULLY_DISCONNECTED=ON \
                       -DFETCHCONTENT_SOURCE_DIR_ARGUM=$(get_build_dir argum) \
                       -DFETCHCONTENT_SOURCE_DIR_ASIO=$(get_build_dir asio)/asio \
                       -DFETCHCONTENT_SOURCE_DIR_ISPTR=$(get_build_dir isptr) \
                       -DFETCHCONTENT_SOURCE_DIR_MODERN-UUID=$(get_build_dir modern-uuid) \
                       -DFETCHCONTENT_SOURCE_DIR_OUTCOME=$(get_build_dir outcome) \
                       -DFETCHCONTENT_SOURCE_DIR_PTL=$(get_build_dir ptl) \
                       -DFETCHCONTENT_SOURCE_DIR_SYS_STRING=$(get_build_dir sys_string) \
                       -DFETCHCONTENT_SOURCE_DIR_TOMLPLUSPLUS=$(get_build_dir tomlplusplus)"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp ${PKG_DIR}/system.d/*.service ${INSTALL}/usr/lib/systemd/system
}

post_install() {
  enable_service wsddn.service
}
