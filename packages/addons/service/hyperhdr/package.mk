# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyperhdr"
PKG_VERSION="22.0.0.0"
PKG_SHA256="5da97008eaa9bfcd051adec695bdde584fe8c91c5295ce67e8d86d423027c5b1"
PKG_REV="0"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/awawa-dev/HyperHDR"
PKG_URL="https://github.com/awawa-dev/HyperHDR/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain flatbuffers:host alsa-lib libjpeg-turbo qt5 systemd rpi_ws281x zstd \
                    hyperhdr-linalg hyperhdr-lunasvg hyperhdr-mdns hyperhdr-nanopb hyperhdr-qmqtt \
                    hyperhdr-sdbus-cpp hyperhdr-stb"
PKG_TOOLCHAIN="cmake"
PKG_SECTION="service"
PKG_SHORTDESC="HyperHDR: an ambient lighting controller"
PKG_LONGDESC="HyperHDR (${PKG_VERSION}) is a highly optimized opensource ambient lighting implementation"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="HyperHDR"
PKG_ADDON_ICON_NAME="HyperHDR"
PKG_ADDON_TYPE="xbmc.service"

if [ "${PROJECT}" = "ARM" -o "${PROJECT}" = "RPi" ]; then
  PKG_WS281X="-DENABLE_WS281XPWM=ON"
else
  PKG_WS281X="-DENABLE_WS281XPWM=OFF"
fi

PKG_CMAKE_OPTS_TARGET="-DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DENABLE_CEC=OFF \
                       -DENABLE_FRAMEBUFFER=OFF \
                       -DENABLE_PIPEWIRE=OFF \
                       -DENABLE_POWER_MANAGEMENT=ON \
                       -DENABLE_SYSTRAY=OFF \
                       -DENABLE_X11=OFF \
                       -DENABLE_ZSTD=ON \
                       ${PKG_WS281X} \
                       -DPLATFORM=linux \
                       -DUSE_CCACHE_CACHING=OFF \
                       -DUSE_PRECOMPILED_HEADERS=OFF \
                       -DUSE_SHARED_LIBS=OFF \
                       -DUSE_STATIC_QT_PLUGINS=ON \
                       -DUSE_SYSTEM_FLATBUFFERS_LIBS=OFF \
                       -DFLATBUFFERS_FLATC_EXECUTABLE=${TOOLCHAIN}/bin/flatc \
                       -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                       -Wno-dev"

pre_configure_target() {
  cat > "${PKG_BUILD}/toolchain-qt5.cmake" <<EOF
include("${CMAKE_CONF}")
list(APPEND CMAKE_FIND_ROOT_PATH "$(get_install_dir qt5)/usr")
EOF
  PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_TOOLCHAIN_FILE=${PKG_BUILD}/toolchain-qt5.cmake"
  pkg_flatbuffers_version=$(get_pkg_version flatbuffers)
  tar --strip-components=1 -xf "${SOURCES}/flatbuffers/flatbuffers-${pkg_flatbuffers_version}.tar.gz" -C "${PKG_BUILD}/external/flatbuffers"
  touch "${PKG_BUILD}/external/flatbuffers/.git"
  cp -a $(get_build_dir rpi_ws281x)/* ${PKG_BUILD}/external/rpi_ws281x
  cp -a $(get_build_dir hyperhdr-lunasvg)/* ${PKG_BUILD}/external/lunasvg
  cp -a $(get_build_dir hyperhdr-nanopb)/* ${PKG_BUILD}/external/nanopb
  cp -a $(get_build_dir hyperhdr-stb)/* ${PKG_BUILD}/external/stb
  cp -a $(get_build_dir hyperhdr-linalg)/* ${PKG_BUILD}/external/linalg
  cp -a $(get_build_dir hyperhdr-mdns)/* ${PKG_BUILD}/external/mdns
  cp -a $(get_build_dir hyperhdr-qmqtt)/* ${PKG_BUILD}/external/qmqtt
  cp -a $(get_build_dir hyperhdr-sdbus-cpp)/* ${PKG_BUILD}/external/sdbus-cpp
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp ${PKG_INSTALL}/usr/bin/hyperhdr ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
